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
#   - OpenROAD on PATH (unless you only want VCD generation)
#   - volare SKY130 PDK installed with primitives and liberty files
#
# Environment variables (optional):
#   VOLARE_ROOT        - Path to volare PDK (default: auto-detect)
#   RUN_REVERSIBLE     - Path to reversible OpenLane run directory
#   RUN_RIPPLE         - Path to ripple OpenLane run directory
#   RUN_CARRY_SELECT   - Path to carry-select OpenLane run directory
#   LIB_TT_LIB         - Override liberty path (tt_025C_1v80) used by OpenROAD Tcl
#
# Usage:
#   chmod +x scripts/run_all.sh
#   scripts/run_all.sh
#
# If using Nix (OpenLane shell), do NOT execute shell.nix directly. Use:
#   nix-shell /path/to/openlane/shell.nix --run "/abs/path/to/scripts/run_all.sh"
###############################################################################

set -euo pipefail

# ============================ Configuration ==================================

# Repository root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Output directory for VCDs
SIM_OUT="${REPO_ROOT}/sim_out"

# Testbench
TB_GL="${REPO_ROOT}/sim/tb_common_gl.v"

# Volare PDK paths (configurable via environment variable)
if [[ -z "${VOLARE_ROOT:-}" ]]; then
  for candidate in \
    "$HOME/.volare/volare/sky130/versions/"*/sky130A \
    "$HOME/.volare/sky130A" \
    "/opt/pdk/sky130A" \
    "${PDK_ROOT:-}/sky130A"; do
    if [[ -n "$candidate" && -d "$candidate" ]]; then
      VOLARE_ROOT="$candidate"
      break
    fi
  done
  # Final fallback to a known version
  VOLARE_ROOT="${VOLARE_ROOT:-$HOME/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A}"
fi

# SKY130 HD cell library model files (try both naming conventions for primitives)
SKY130_VERILOG_DIR="${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/verilog"
PRIMS_A="${SKY130_VERILOG_DIR}/primitives.v"
PRIMS_B="${SKY130_VERILOG_DIR}/sky130_fd_sc_hd__primitives.v"
if [[ -f "$PRIMS_A" ]]; then
  SKY130_PRIMITIVES="$PRIMS_A"
elif [[ -f "$PRIMS_B" ]]; then
  SKY130_PRIMITIVES="$PRIMS_B"
else
  echo "ERROR: SKY130 primitives not found. Checked:" >&2
  echo "  - $PRIMS_A" >&2
  echo "  - $PRIMS_B" >&2
  echo "Ensure VOLARE_ROOT is correct. Current: $VOLARE_ROOT" >&2
  exit 1
fi
SKY130_CELLS="${SKY130_VERILOG_DIR}/sky130_fd_sc_hd.v"

# Liberty (tt_025C_1v80)
LIB_TT_LIB="${LIB_TT_LIB:-${VOLARE_ROOT}/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib}"

# Function to find the latest run directory
find_latest_run() {
  local base_dir="$1"
  if [[ -d "$base_dir" ]]; then
    ls -td "$base_dir"/RUN_* 2>/dev/null | head -1
  fi
}

# OpenLane run directories (configurable via environment or auto-detected)
RUN_REVERSIBLE="${RUN_REVERSIBLE:-$(find_latest_run "${REPO_ROOT}/openlane/reversable-openlane/runs")}"
RUN_RIPPLE="${RUN_RIPPLE:-$(find_latest_run "${REPO_ROOT}/openlane/conventional-ripple-openlane/runs")}"
RUN_CARRY_SELECT="${RUN_CARRY_SELECT:-$(find_latest_run "${REPO_ROOT}/openlane/conventional-carry-select-openlane/runs")}"

# Choose first existing file from a list
choose_first() {
  for f in "$@"; do
    if [[ -n "$f" && -f "$f" ]]; then
      echo "$f"
      return 0
    fi
  done
  return 1
}

# Powered netlist files (.pnl.v), prefer final/pnl, fallback to step 36
PNL_REVERSIBLE="$(choose_first \
  "${RUN_REVERSIBLE}/final/pnl/reversible_wrapper.pnl.v" \
  "${RUN_REVERSIBLE}/36-openroad-resizertimingpostcts/reversible_wrapper.pnl.v")" || {
  echo "ERROR: Reversible powered netlist not found." >&2; exit 1; }

PNL_RIPPLE="$(choose_first \
  "${RUN_RIPPLE}/final/pnl/ripple_adder_wrapper.pnl.v" \
  "${RUN_RIPPLE}/36-openroad-resizertimingpostcts/ripple_adder_wrapper.pnl.v")" || {
  echo "ERROR: Ripple powered netlist not found." >&2; exit 1; }

# Carry-select has two possible top names: carry_select_adder_wrapper or carry_select_wrapper
PNL_CARRY_SELECT="$(choose_first \
  "${RUN_CARRY_SELECT}/final/pnl/carry_select_adder_wrapper.pnl.v" \
  "${RUN_CARRY_SELECT}/final/pnl/carry_select_wrapper.pnl.v" \
  "${RUN_CARRY_SELECT}/36-openroad-resizertimingpostcts/carry_select_adder_wrapper.pnl.v" \
  "${RUN_CARRY_SELECT}/36-openroad-resizertimingpostcts/carry_select_wrapper.pnl.v")" || {
  echo "ERROR: Carry-select powered netlist not found." >&2; exit 1; }

# ============================ Helper Functions ===============================

print_section() {
  echo ""
  echo "==============================================================================="
  echo " $1"
  echo "==============================================================================="
}

check_tool() {
  local t="$1"
  if ! command -v "$t" >/dev/null 2>&1; then
    echo "ERROR: Required tool not found on PATH: $t" >&2
    return 1
  fi
  echo "✓ $t: $(command -v "$t")"
}

# ============================ Dependency Checks ==============================

print_section "Checking Dependencies"

check_tool iverilog || { echo "Install iverilog (e.g., brew install icarus-verilog)"; exit 1; }
check_tool vvp || { echo "vvp missing"; exit 1; }
check_tool python3 || { echo "python3 missing"; exit 1; }

# OpenROAD is optional until power analysis step; we’ll check again later
if command -v openroad >/dev/null 2>&1; then
  echo "✓ openroad: $(command -v openroad)"
  openroad -version 2>/dev/null | head -1 || true
else
  echo "NOTE: openroad not found on PATH. VCDs will still be generated; power analysis will be skipped."
fi

print_section "Verifying PDK Files"
[[ -f "$SKY130_PRIMITIVES" ]] || { echo "Missing primitives: $SKY130_PRIMITIVES"; exit 1; }
echo "✓ SKY130 primitives: $SKY130_PRIMITIVES"
[[ -f "$SKY130_CELLS" ]] || { echo "Missing cell models: $SKY130_CELLS"; exit 1; }
echo "✓ SKY130 cells: $SKY130_CELLS"
[[ -f "$LIB_TT_LIB" ]] || { echo "Missing liberty: $LIB_TT_LIB"; exit 1; }
echo "✓ Liberty (tt): $LIB_TT_LIB"

print_section "Verifying Netlists"
echo "✓ Reversible: $PNL_REVERSIBLE"
echo "✓ Ripple:     $PNL_RIPPLE"
echo "✓ CarrySel:   $PNL_CARRY_SELECT"

print_section "Verifying Testbench"
[[ -f "$TB_GL" ]] || { echo "Missing TB: $TB_GL"; exit 1; }
echo "✓ Testbench: $TB_GL"

mkdir -p "$SIM_OUT"
echo "✓ Simulation output directory: $SIM_OUT"

# ============================ Compile and Simulate ===========================

compile_and_simulate() {
  local design_key="$1"      # reversible | ripple | carry_select
  local netlist="$2"
  local wrap_define="$3"     # WRAP_REVERSIBLE | WRAP_RIPPLE | WRAP_CARRY_SELECT

  local vcd_output="${SIM_OUT}/${design_key}.vcd"
  local vvp_output="${SIM_OUT}/${design_key}.vvp"

  print_section "Compiling and Simulating: $design_key"

  echo "Compiling with iverilog..."
  iverilog -g2012 -o "$vvp_output" \
    -DFUNCTIONAL -DUSE_POWER_PINS \
    -D"${wrap_define}" \
    -DVCD_FILE="\"$vcd_output\"" \
    -s tb_common_gl \
    "$SKY130_PRIMITIVES" \
    "$SKY130_CELLS" \
    "$netlist" \
    "$TB_GL"

  echo "Running simulation..."
  vvp "$vvp_output"

  if [[ ! -f "$vcd_output" ]]; then
    echo "ERROR: VCD file not generated: $vcd_output" >&2
    exit 1
  fi
  echo "✓ VCD generated: $vcd_output ($(du -h "$vcd_output" | awk '{print $1}'))"
}

compile_and_simulate "reversible"   "$PNL_REVERSIBLE"   "WRAP_REVERSIBLE"
compile_and_simulate "ripple"       "$PNL_RIPPLE"       "WRAP_RIPPLE"
compile_and_simulate "carry_select" "$PNL_CARRY_SELECT" "WRAP_CARRY_SELECT"

# ============================ OpenROAD Power Analysis ========================

print_section "Running OpenROAD Power Analysis"

if ! command -v openroad >/dev/null 2>&1; then
  cat <<EOF
OpenROAD not found on PATH. Skipping power analysis.

Install options:
- macOS (Homebrew):  brew update && brew install openroad
- Ubuntu/Debian:     sudo add-apt-repository ppa:openroad-tool/ppa && sudo apt-get update && sudo apt-get install openroad
- Conda:             conda create -n openroad -c conda-forge -c openroad openroad && conda activate openroad
- Docker:            docker pull theopenroad/openroad:latest
Verify with: openroad -version

Re-run this script after installation to generate power reports and CSV.
EOF
  exit 0
fi

# Export the liberty path so Tcl can optionally use it
export LIB_TT_LIB

openroad -exit "${REPO_ROOT}/scripts/openroad_power_reversible.tcl" || true
openroad -exit "${REPO_ROOT}/scripts/openroad_power_ripple.tcl" || true
openroad -exit "${REPO_ROOT}/scripts/openroad_power_carry_select.tcl" || true

# ============================ Parse Reports to CSV ===========================

print_section "Generating Power Summary CSV"

PARSE_SCRIPT="${REPO_ROOT}/scripts/parse_power_reports.py"
if [[ ! -f "$PARSE_SCRIPT" ]]; then
  echo "ERROR: Parser not found: $PARSE_SCRIPT" >&2
  exit 1
fi

python3 "$PARSE_SCRIPT" "${REPO_ROOT}/scripts/power_summary_tt_025C_1v80.csv"

CSV_OUTPUT="${REPO_ROOT}/scripts/power_summary_tt_025C_1v80.csv"
if [[ ! -f "$CSV_OUTPUT" ]]; then
  echo "ERROR: CSV summary not generated: $CSV_OUTPUT" >&2
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
echo "  Power Reports (see respective run directories):"
echo "    - reversible_wrapper:   power_reversible_wrapper_tt_025C_1v80.rpt"
echo "    - ripple_adder_wrapper: power_ripple_adder_wrapper_tt_025C_1v80.rpt"
echo "    - carry_select_*:       power_carry_select_*_tt_025C_1v80.rpt"
echo ""
echo "  Summary:"
echo "    - $CSV_OUTPUT"
echo ""
echo "Tip (Nix shell): nix-shell /path/to/openlane/shell.nix --run \"$0\""
#!/bin/bash
#------------------------------------------------------------------------------
# run_all.sh - End-to-end power analysis workflow
#
# Runs gate-level simulations for all three adder designs, performs OpenROAD
# power analysis, and generates a CSV comparison report.
#
# Requirements:
#   - Icarus Verilog (iverilog, vvp)
#   - OpenROAD
#   - Python 3
#   - Sky130 PDK (volare-managed or custom path)
#
# Usage:
#   ./scripts/run_all.sh [options]
#
# Options:
#   --sim-only     Only run simulations, skip power analysis
#   --power-only   Only run power analysis, skip simulations
#   --parse-only   Only parse existing power reports
#   --help         Show this help message
#------------------------------------------------------------------------------

set -e  # Exit on error

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Sky130 standard cell library path
# Set SKY130_LIB_DIR environment variable or update the default path below
# Common locations:
#   volare: ~/.volare/volare/sky130/versions/<version>/sky130A/libs.ref/sky130_fd_sc_hd
#   OpenLane: $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd
: "${SKY130_LIB_DIR:=${PDK_ROOT:-/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A}/libs.ref/sky130_fd_sc_hd}"
SKY130_VERILOG="${SKY130_LIB_DIR}/verilog/sky130_fd_sc_hd.v"

# Output directories
SIM_OUT_DIR="${REPO_ROOT}/sim_out"
POWER_REPORTS_DIR="${REPO_ROOT}/power_reports"

# Design configurations
# Format: DESIGN_NAME|DEFINE|VCD_FILE|NETLIST_PATH
DESIGNS=(
    "reversible|DESIGN_REVERSIBLE|reversible.vcd|openlane/reversable-openlane/runs/RUN_2025-11-05_20-20-54/36-openroad-resizertimingpostcts/reversible_wrapper.pnl.v"
    "ripple|DESIGN_RIPPLE|ripple.vcd|openlane/conventional-ripple-openlane/runs/RUN_2025-11-05_20-17-51/36-openroad-resizertimingpostcts/ripple_adder_wrapper.pnl.v"
    "carry_select|DESIGN_CARRY_SELECT|carry_select.vcd|openlane/conventional-carry-select-openlane/runs/RUN_2025-11-05_20-14-14/36-openroad-resizertimingpostcts/carry_select_wrapper.pnl.v"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#------------------------------------------------------------------------------
# Helper functions
#------------------------------------------------------------------------------

print_header() {
    echo -e "${BLUE}==================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}==================================================================${NC}"
}

print_step() {
    echo -e "${GREEN}>>> $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}WARNING: $1${NC}"
}

print_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        print_error "$1 is not installed or not in PATH"
        return 1
    fi
    return 0
}

show_help() {
    head -30 "$0" | tail -25
    exit 0
}

#------------------------------------------------------------------------------
# Simulation
#------------------------------------------------------------------------------

run_simulations() {
    print_header "Running Gate-Level Simulations"
    
    # Check for Icarus Verilog
    if ! check_command iverilog; then
        print_error "Icarus Verilog (iverilog) is required for simulation"
        exit 1
    fi
    
    # Check for Sky130 Verilog models
    if [[ ! -f "$SKY130_VERILOG" ]]; then
        print_warning "Sky130 Verilog models not found at: $SKY130_VERILOG"
        print_warning "Please update SKY130_LIB_DIR in this script"
    fi
    
    # Create output directory
    mkdir -p "$SIM_OUT_DIR"
    
    cd "$REPO_ROOT"
    
    for design_config in "${DESIGNS[@]}"; do
        IFS='|' read -r design_name define vcd_file netlist_path <<< "$design_config"
        
        print_step "Simulating $design_name design..."
        
        if [[ ! -f "$netlist_path" ]]; then
            print_error "Netlist not found: $netlist_path"
            continue
        fi
        
        # Compile with Icarus Verilog
        iverilog \
            -g2012 \
            -D${define} \
            -DVCD_FILE=\"${SIM_OUT_DIR}/${vcd_file}\" \
            -o "${SIM_OUT_DIR}/${design_name}_sim" \
            -I"${SKY130_LIB_DIR}/verilog" \
            "${SKY130_VERILOG}" \
            "$netlist_path" \
            sim/tb_common_gl.v \
            2>&1 | tee "${SIM_OUT_DIR}/${design_name}_compile.log" || {
                print_error "Compilation failed for $design_name"
                continue
            }
        
        # Run simulation
        vvp "${SIM_OUT_DIR}/${design_name}_sim" \
            2>&1 | tee "${SIM_OUT_DIR}/${design_name}_sim.log" || {
                print_error "Simulation failed for $design_name"
                continue
            }
        
        if [[ -f "${SIM_OUT_DIR}/${vcd_file}" ]]; then
            echo -e "${GREEN}  VCD generated: ${SIM_OUT_DIR}/${vcd_file}${NC}"
        else
            print_warning "VCD file not generated for $design_name"
        fi
    done
    
    echo ""
    print_step "Simulations complete"
}

#------------------------------------------------------------------------------
# Power Analysis
#------------------------------------------------------------------------------

run_power_analysis() {
    print_header "Running OpenROAD Power Analysis"
    
    # Check for OpenROAD
    if ! check_command openroad; then
        print_error "OpenROAD is required for power analysis"
        exit 1
    fi
    
    # Create output directory
    mkdir -p "$POWER_REPORTS_DIR"
    
    cd "$REPO_ROOT"
    
    local tcl_scripts=(
        "scripts/openroad_power_reversible.tcl"
        "scripts/openroad_power_ripple.tcl"
        "scripts/openroad_power_carry_select.tcl"
    )
    
    for tcl_script in "${tcl_scripts[@]}"; do
        script_name=$(basename "$tcl_script" .tcl)
        print_step "Running $script_name..."
        
        if [[ ! -f "$tcl_script" ]]; then
            print_error "TCL script not found: $tcl_script"
            continue
        fi
        
        openroad -exit "$tcl_script" \
            2>&1 | tee "${POWER_REPORTS_DIR}/${script_name}.log" || {
                print_warning "Power analysis for $script_name completed with warnings/errors"
            }
    done
    
    echo ""
    print_step "Power analysis complete"
}

#------------------------------------------------------------------------------
# Parse Reports
#------------------------------------------------------------------------------

parse_reports() {
    print_header "Parsing Power Reports"
    
    cd "$REPO_ROOT"
    
    if [[ ! -d "$POWER_REPORTS_DIR" ]]; then
        print_error "Power reports directory not found: $POWER_REPORTS_DIR"
        exit 1
    fi
    
    # Find all .rpt files
    local report_files=($(find "$POWER_REPORTS_DIR" -name "*.rpt" -type f 2>/dev/null))
    
    if [[ ${#report_files[@]} -eq 0 ]]; then
        print_error "No power report files found in $POWER_REPORTS_DIR"
        exit 1
    fi
    
    print_step "Found ${#report_files[@]} power report(s)"
    
    # Run Python parser
    python3 scripts/parse_power_reports.py \
        "${report_files[@]}" \
        -o "${POWER_REPORTS_DIR}/power_comparison.csv" || {
            print_error "Failed to parse power reports"
            exit 1
        }
    
    echo ""
    print_step "CSV report generated: ${POWER_REPORTS_DIR}/power_comparison.csv"
}

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------

main() {
    local run_sim=true
    local run_power=true
    local run_parse=true
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --sim-only)
                run_power=false
                run_parse=false
                shift
                ;;
            --power-only)
                run_sim=false
                run_parse=false
                shift
                ;;
            --parse-only)
                run_sim=false
                run_power=false
                shift
                ;;
            --help|-h)
                show_help
                ;;
            *)
                print_error "Unknown option: $1"
                show_help
                ;;
        esac
    done
    
    print_header "End-to-End Power Analysis Workflow"
    echo "Repository: $REPO_ROOT"
    echo "Timestamp: $(date)"
    echo ""
    
    # Run selected steps
    if $run_sim; then
        run_simulations
        echo ""
    fi
    
    if $run_power; then
        run_power_analysis
        echo ""
    fi
    
    if $run_parse; then
        parse_reports
        echo ""
    fi
    
    print_header "Workflow Complete"
    echo ""
    echo "Output files:"
    echo "  - Simulation VCDs: $SIM_OUT_DIR/*.vcd"
    echo "  - Power reports: $POWER_REPORTS_DIR/*.rpt"
    echo "  - CSV comparison: $POWER_REPORTS_DIR/power_comparison.csv"
}

# Run main
main "$@"
