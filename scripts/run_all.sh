#!/usr/bin/env bash
###############################################################################
# run_all.sh - Power Comparison Workflow for SKY130 Gate-Level Designs
#
# This script:
#   1) Compiles gate-level netlists (with SKY130 primitives) using Icarus Verilog
#   2) Runs simulations to generate VCD waveforms
#   3) Runs OpenROAD power analysis using activity from VCDs
#   4) Parses OpenROAD power reports into a summary CSV
#
# Prerequisites:
#   - Icarus Verilog (iverilog, vvp) on PATH
#   - OpenROAD on PATH
#   - volare SKY130 PDK installed with primitives and liberty files
#
# Environment variables (optional):
#   VOLARE_ROOT        - Path to volare PDK (default: auto-detect or ~/.volare/...)
#   RUN_REVERSIBLE     - Path to reversible OpenLane run directory
#   RUN_RIPPLE         - Path to ripple OpenLane run directory
#   RUN_CARRY_SELECT   - Path to carry-select OpenLane run directory
#
# Usage:
#   chmod +x scripts/run_all.sh
#   scripts/run_all.sh
###############################################################################

set -e  # Exit on first error

# ============================ Configuration ==================================

# Repository root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Volare PDK paths (configurable via environment variable)
# If not set, try common default paths
if [[ -z "$VOLARE_ROOT" ]]; then
    # Try to auto-detect volare installation
    for candidate in \
        "$HOME/.volare/volare/sky130/versions/"*/sky130A \
        "$HOME/.volare/sky130A" \
        "/opt/pdk/sky130A" \
        "$PDK_ROOT/sky130A"; do
        if [[ -d "$candidate" ]]; then
            VOLARE_ROOT="$candidate"
            break
        fi
    done
    # Final fallback to the known version in the repo context
    VOLARE_ROOT="${VOLARE_ROOT:-$HOME/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A}"
fi

# SKY130 HD cell library paths
SKY130_PRIMITIVES="${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
SKY130_CELLS="${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
LIB_TT="${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

# Output directory for VCDs
SIM_OUT="${REPO_ROOT}/sim_out"

# Testbench
TB_GL="${REPO_ROOT}/sim/tb_common_gl.v"

# Function to find the latest run directory
find_latest_run() {
    local base_dir="$1"
    # Find the most recently modified run directory
    if [[ -d "$base_dir" ]]; then
        ls -td "$base_dir"/RUN_* 2>/dev/null | head -1
    fi
}

# OpenLane run directories (configurable via environment or auto-detected)
if [[ -z "$RUN_REVERSIBLE" ]]; then
    RUN_REVERSIBLE="$(find_latest_run "${REPO_ROOT}/openlane/reversable-openlane/runs")"
fi
if [[ -z "$RUN_RIPPLE" ]]; then
    RUN_RIPPLE="$(find_latest_run "${REPO_ROOT}/openlane/conventional-ripple-openlane/runs")"
fi
if [[ -z "$RUN_CARRY_SELECT" ]]; then
    RUN_CARRY_SELECT="$(find_latest_run "${REPO_ROOT}/openlane/conventional-carry-select-openlane/runs")"
fi

# Powered netlist files (.pnl.v)
PNL_REVERSIBLE="${RUN_REVERSIBLE}/final/pnl/reversible_wrapper.pnl.v"
PNL_RIPPLE="${RUN_RIPPLE}/final/pnl/ripple_adder_wrapper.pnl.v"
PNL_CARRY_SELECT="${RUN_CARRY_SELECT}/final/pnl/carry_select_wrapper.pnl.v"

# SPEF files for parasitic extraction (nom corner)
SPEF_REVERSIBLE="${RUN_REVERSIBLE}/final/spef/nom/reversible_wrapper.nom.spef"
SPEF_RIPPLE="${RUN_RIPPLE}/final/spef/nom/ripple_adder_wrapper.nom.spef"
SPEF_CARRY_SELECT="${RUN_CARRY_SELECT}/final/spef/nom/carry_select_wrapper.nom.spef"

# ODB files
ODB_REVERSIBLE="${RUN_REVERSIBLE}/final/odb/reversible_wrapper.odb"
ODB_RIPPLE="${RUN_RIPPLE}/final/odb/ripple_adder_wrapper.odb"
ODB_CARRY_SELECT="${RUN_CARRY_SELECT}/final/odb/carry_select_wrapper.odb"

# ============================ Helper Functions ===============================

print_section() {
    echo ""
    echo "==============================================================================="
    echo " $1"
    echo "==============================================================================="
}

print_error() {
    echo "ERROR: $1" >&2
}

check_file_exists() {
    if [[ ! -f "$1" ]]; then
        print_error "Required file not found: $1"
        exit 1
    fi
}

# ============================ Dependency Checks ==============================

print_section "Checking Dependencies"

# Check for Icarus Verilog
if ! command -v iverilog &> /dev/null; then
    print_error "iverilog (Icarus Verilog) not found on PATH."
    echo ""
    echo "Installation options:"
    echo "  - macOS:   brew install icarus-verilog"
    echo "  - Ubuntu:  sudo apt-get install iverilog"
    echo "  - Conda:   conda install -c conda-forge iverilog"
    exit 1
fi
echo "✓ iverilog found: $(which iverilog)"

if ! command -v vvp &> /dev/null; then
    print_error "vvp (Icarus Verilog VVP) not found on PATH."
    exit 1
fi
echo "✓ vvp found: $(which vvp)"

# Check for OpenROAD
if ! command -v openroad &> /dev/null; then
    print_error "openroad not found on PATH."
    echo ""
    echo "OpenROAD is required for power analysis. Installation options:"
    echo ""
    echo "  Homebrew (macOS):"
    echo "    brew install openroad"
    echo ""
    echo "  Ubuntu PPA:"
    echo "    sudo add-apt-repository ppa:openroad/openroad"
    echo "    sudo apt-get update"
    echo "    sudo apt-get install openroad"
    echo ""
    echo "  Conda (cross-platform):"
    echo "    conda install -c conda-forge openroad"
    echo ""
    echo "  Docker:"
    echo "    docker pull openroad/openroad"
    echo "    # Then run scripts inside the container"
    echo ""
    echo "After installation, verify with: openroad -version"
    exit 1
fi
echo "✓ openroad found: $(which openroad)"
echo "  Version: $(openroad -version 2>&1 | head -1 || echo 'unknown')"

# Check for Python (for parse_power_reports.py)
if ! command -v python3 &> /dev/null; then
    print_error "python3 not found on PATH."
    exit 1
fi
echo "✓ python3 found: $(which python3)"

# ============================ Verify PDK Files ===============================

print_section "Verifying SKY130 PDK Files"

# Check SKY130 primitives (try alternate paths if default doesn't exist)
if [[ ! -f "$SKY130_PRIMITIVES" ]]; then
    # Try alternate naming convention
    ALT_PRIMITIVES="${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd__primitives.v"
    if [[ -f "$ALT_PRIMITIVES" ]]; then
        SKY130_PRIMITIVES="$ALT_PRIMITIVES"
    else
        print_error "SKY130 primitives file not found."
        echo "Searched:"
        echo "  - $SKY130_PRIMITIVES"
        echo "  - $ALT_PRIMITIVES"
        echo ""
        echo "Ensure volare PDK is installed and VOLARE_ROOT is set correctly."
        echo "Current VOLARE_ROOT: $VOLARE_ROOT"
        exit 1
    fi
fi
echo "✓ SKY130 primitives: $SKY130_PRIMITIVES"

# Check SKY130 cells
check_file_exists "$SKY130_CELLS"
echo "✓ SKY130 cells: $SKY130_CELLS"

# Check liberty file
check_file_exists "$LIB_TT"
echo "✓ Liberty file: $LIB_TT"

# ============================ Verify Netlists ================================

print_section "Verifying Netlists"

check_file_exists "$PNL_REVERSIBLE"
echo "✓ Reversible netlist: $PNL_REVERSIBLE"

check_file_exists "$PNL_RIPPLE"
echo "✓ Ripple adder netlist: $PNL_RIPPLE"

check_file_exists "$PNL_CARRY_SELECT"
echo "✓ Carry-select adder netlist: $PNL_CARRY_SELECT"

# ============================ Verify Testbench ===============================

print_section "Verifying Testbench"

check_file_exists "$TB_GL"
echo "✓ Testbench: $TB_GL"

# ============================ Create Output Directory ========================

mkdir -p "$SIM_OUT"
echo "✓ Simulation output directory: $SIM_OUT"

# ============================ Compile and Simulate ===========================

compile_and_simulate() {
    local design_name="$1"
    local netlist="$2"
    local top_module="$3"
    local sim_define="$4"
    local vcd_output="${SIM_OUT}/${design_name}.vcd"
    local vvp_output="${SIM_OUT}/${design_name}.vvp"

    print_section "Compiling and Simulating: $design_name"

    echo "Compiling with iverilog..."
    echo "  - Netlist: $netlist"
    echo "  - Top module: $top_module"
    echo "  - Sim define: $sim_define"

    # Compile with:
    #   -DFUNCTIONAL: Skip timing checks (avoid CLK_delayed/D_delayed issues)
    #   -DUNIT_DELAY=#1: Optional unit delay for simulation
    #   -D<SIM_*>: Select which DUT to instantiate in testbench
    #   Include SKY130 primitives and cell models
    iverilog \
        -DFUNCTIONAL \
        -DUNIT_DELAY='#1' \
        -D"$sim_define" \
        -DVCD_FILE="\"$vcd_output\"" \
        -g2012 \
        -o "$vvp_output" \
        -s tb_common_gl \
        "$SKY130_PRIMITIVES" \
        "$SKY130_CELLS" \
        "$netlist" \
        "$TB_GL"

    echo "Running simulation..."
    vvp "$vvp_output"

    # Verify VCD was generated
    if [[ ! -f "$vcd_output" ]]; then
        print_error "VCD file not generated: $vcd_output"
        exit 1
    fi
    echo "✓ VCD generated: $vcd_output ($(du -h "$vcd_output" | cut -f1))"
}

# Compile and simulate all three designs
compile_and_simulate "reversible" "$PNL_REVERSIBLE" "reversible_wrapper" "SIM_REVERSIBLE"
compile_and_simulate "ripple" "$PNL_RIPPLE" "ripple_adder_wrapper" "SIM_RIPPLE"
compile_and_simulate "carry_select" "$PNL_CARRY_SELECT" "carry_select_wrapper" "SIM_CARRY_SELECT"

# ============================ OpenROAD Power Analysis ========================

run_power_analysis() {
    local design_name="$1"
    local tcl_script="${REPO_ROOT}/scripts/openroad_power_${design_name}.tcl"
    local vcd_file="${SIM_OUT}/${design_name}.vcd"
    local report_file="${REPO_ROOT}/scripts/${design_name}_power_report.txt"

    print_section "Running OpenROAD Power Analysis: $design_name"

    check_file_exists "$tcl_script"
    check_file_exists "$vcd_file"

    echo "Running OpenROAD with TCL script: $tcl_script"

    # Run OpenROAD power analysis
    openroad -exit "$tcl_script" > "$report_file" 2>&1

    if [[ ! -f "$report_file" ]]; then
        print_error "Power report not generated: $report_file"
        exit 1
    fi
    echo "✓ Power report: $report_file"
}

run_power_analysis "reversible"
run_power_analysis "ripple"
run_power_analysis "carry_select"

# ============================ Parse Reports to CSV ===========================

print_section "Generating Power Summary CSV"

PARSE_SCRIPT="${REPO_ROOT}/scripts/parse_power_reports.py"
check_file_exists "$PARSE_SCRIPT"

python3 "$PARSE_SCRIPT"

CSV_OUTPUT="${REPO_ROOT}/scripts/power_summary_tt_025C_1v80.csv"
if [[ ! -f "$CSV_OUTPUT" ]]; then
    print_error "CSV summary not generated: $CSV_OUTPUT"
    exit 1
fi
echo "✓ Power summary CSV: $CSV_OUTPUT"

# ============================ Summary ========================================

print_section "Power Comparison Workflow Complete"

echo "Generated files:"
echo "  VCDs:"
echo "    - $SIM_OUT/reversible.vcd"
echo "    - $SIM_OUT/ripple.vcd"
echo "    - $SIM_OUT/carry_select.vcd"
echo ""
echo "  Power Reports:"
echo "    - ${REPO_ROOT}/scripts/reversible_power_report.txt"
echo "    - ${REPO_ROOT}/scripts/ripple_power_report.txt"
echo "    - ${REPO_ROOT}/scripts/carry_select_power_report.txt"
echo ""
echo "  Summary:"
echo "    - $CSV_OUTPUT"
echo ""
echo "To view the summary:"
echo "  cat $CSV_OUTPUT"

exit 0
