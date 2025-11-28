#!/usr/bin/env bash
# run_all.sh - End-to-end reproducible power analysis workflow
# Compiles gate-level netlists with Icarus Verilog, runs simulation,
# generates VCDs, and runs OpenROAD power analysis.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPTS_DIR="${REPO_ROOT}/scripts"
SIM_OUT="${REPO_ROOT}/sim_out"

# Create output directory
mkdir -p "${SIM_OUT}"

echo "========================================"
echo "Power Analysis Workflow"
echo "========================================"
echo "Repository root: ${REPO_ROOT}"
echo ""

# ---------------------------------------------------------------------------
# Auto-detect volare PDK root
# ---------------------------------------------------------------------------
if [ -z "${VOLARE_ROOT:-}" ]; then
    if [ -d "${HOME}/.volare" ]; then
        VOLARE_ROOT="${HOME}/.volare"
    elif [ -d "/opt/volare" ]; then
        VOLARE_ROOT="/opt/volare"
    else
        echo "ERROR: Could not auto-detect VOLARE_ROOT. Please set it manually."
        echo "       e.g., export VOLARE_ROOT=\$HOME/.volare"
        exit 1
    fi
fi
echo "Using VOLARE_ROOT: ${VOLARE_ROOT}"

# ---------------------------------------------------------------------------
# Find Sky130 PDK version directory
# ---------------------------------------------------------------------------
SKY130_VERSIONS_DIR="${VOLARE_ROOT}/volare/sky130/versions"
if [ ! -d "${SKY130_VERSIONS_DIR}" ]; then
    # Alternative path structure
    SKY130_VERSIONS_DIR="${VOLARE_ROOT}/sky130/versions"
fi

if [ -d "${SKY130_VERSIONS_DIR}" ]; then
    # Get the latest version (or the one that exists)
    SKY130_VERSION=$(ls -1 "${SKY130_VERSIONS_DIR}" 2>/dev/null | head -n1)
    if [ -n "${SKY130_VERSION}" ]; then
        SKY130_ROOT="${SKY130_VERSIONS_DIR}/${SKY130_VERSION}/sky130A"
    fi
fi

# Fallback to common paths
if [ -z "${SKY130_ROOT:-}" ] || [ ! -d "${SKY130_ROOT:-}" ]; then
    # Try common locations
    for candidate in \
        "${VOLARE_ROOT}/sky130A" \
        "/usr/share/pdk/sky130A" \
        "${PDK_ROOT:-/dev/null}/sky130A"; do
        if [ -d "${candidate}" ]; then
            SKY130_ROOT="${candidate}"
            break
        fi
    done
fi

if [ -z "${SKY130_ROOT:-}" ] || [ ! -d "${SKY130_ROOT}" ]; then
    echo "ERROR: Could not find Sky130 PDK root."
    echo "       Please ensure Sky130 is installed via volare or set SKY130_ROOT manually."
    exit 1
fi
echo "Using SKY130_ROOT: ${SKY130_ROOT}"

# ---------------------------------------------------------------------------
# Locate Sky130 Verilog models and Liberty files
# ---------------------------------------------------------------------------
SKY130_LIBS_REF="${SKY130_ROOT}/libs.ref/sky130_fd_sc_hd"

# Find primitives file (may be named primitives.v or sky130_fd_sc_hd__primitives.v)
PRIMITIVES_FILE=""
for prim in \
    "${SKY130_LIBS_REF}/verilog/primitives.v" \
    "${SKY130_LIBS_REF}/verilog/sky130_fd_sc_hd__primitives.v"; do
    if [ -f "${prim}" ]; then
        PRIMITIVES_FILE="${prim}"
        break
    fi
done

# Find cells file
CELLS_FILE=""
for cells in \
    "${SKY130_LIBS_REF}/verilog/sky130_fd_sc_hd.v"; do
    if [ -f "${cells}" ]; then
        CELLS_FILE="${cells}"
        break
    fi
done

# Liberty file for power analysis
if [ -z "${LIB_TT_LIB:-}" ]; then
    LIB_TT_LIB="${SKY130_LIBS_REF}/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
fi
export LIB_TT_LIB

echo "Primitives file: ${PRIMITIVES_FILE:-NOT FOUND}"
echo "Cells file: ${CELLS_FILE:-NOT FOUND}"
echo "Liberty file: ${LIB_TT_LIB}"

# Verify files exist
if [ -z "${PRIMITIVES_FILE}" ] || [ ! -f "${PRIMITIVES_FILE}" ]; then
    echo "WARNING: Sky130 primitives file not found. Gate-level simulation may fail."
fi
if [ -z "${CELLS_FILE}" ] || [ ! -f "${CELLS_FILE}" ]; then
    echo "WARNING: Sky130 cells file not found. Gate-level simulation may fail."
fi
if [ ! -f "${LIB_TT_LIB}" ]; then
    echo "WARNING: Liberty file not found. OpenROAD power analysis may fail."
fi

echo ""

# ---------------------------------------------------------------------------
# Auto-detect OpenLane run directories
# ---------------------------------------------------------------------------
REVERSIBLE_OPENLANE="${REPO_ROOT}/openlane/reversable-openlane"
RIPPLE_OPENLANE="${REPO_ROOT}/openlane/conventional-ripple-openlane"
CARRY_SELECT_OPENLANE="${REPO_ROOT}/openlane/conventional-carry-select-openlane"

# Function to find latest run directory
find_latest_run() {
    local design_dir="$1"
    local runs_dir="${design_dir}/runs"
    if [ -d "${runs_dir}" ]; then
        ls -1d "${runs_dir}"/RUN_* 2>/dev/null | sort -r | head -n1
    fi
}

# Set run directories (use env vars if set, otherwise auto-detect)
RUN_REVERSIBLE="${RUN_REVERSIBLE:-$(find_latest_run "${REVERSIBLE_OPENLANE}")}"
RUN_RIPPLE="${RUN_RIPPLE:-$(find_latest_run "${RIPPLE_OPENLANE}")}"
RUN_CARRY_SELECT="${RUN_CARRY_SELECT:-$(find_latest_run "${CARRY_SELECT_OPENLANE}")}"

echo "OpenLane run directories:"
echo "  Reversible:   ${RUN_REVERSIBLE:-NOT FOUND}"
echo "  Ripple:       ${RUN_RIPPLE:-NOT FOUND}"
echo "  Carry-Select: ${RUN_CARRY_SELECT:-NOT FOUND}"
echo ""

# ---------------------------------------------------------------------------
# Function to find powered netlist
# ---------------------------------------------------------------------------
find_pnl() {
    local run_dir="$1"
    local design_name="$2"
    
    # Prefer final/pnl/*.pnl.v
    local final_pnl="${run_dir}/final/pnl/${design_name}.pnl.v"
    if [ -f "${final_pnl}" ]; then
        echo "${final_pnl}"
        return
    fi
    
    # Fallback to 36-openroad-resizertimingpostcts
    local fallback_pnl="${run_dir}/36-openroad-resizertimingpostcts/${design_name}.pnl.v"
    if [ -f "${fallback_pnl}" ]; then
        echo "${fallback_pnl}"
        return
    fi
    
    # Try to find any pnl.v file in the run directory
    find "${run_dir}" -name "${design_name}.pnl.v" 2>/dev/null | head -n1
}

# ---------------------------------------------------------------------------
# Check for iverilog
# ---------------------------------------------------------------------------
if ! command -v iverilog &> /dev/null; then
    echo "ERROR: Icarus Verilog (iverilog) not found on PATH."
    echo "       Please install it or add it to your PATH."
    echo "       On macOS: brew install icarus-verilog"
    echo "       On Ubuntu: sudo apt install iverilog"
    exit 1
fi
echo "Found iverilog: $(which iverilog)"

# ---------------------------------------------------------------------------
# Check for testbench
# ---------------------------------------------------------------------------
TB_FILE="${REPO_ROOT}/sim/tb_common_gl.v"
if [ ! -f "${TB_FILE}" ]; then
    echo "ERROR: Testbench not found at ${TB_FILE}"
    exit 1
fi
echo "Using testbench: ${TB_FILE}"
echo ""

# ---------------------------------------------------------------------------
# Compile and simulate each design
# ---------------------------------------------------------------------------
compile_and_simulate() {
    local design_name="$1"
    local pnl_file="$2"
    local sim_macro="$3"
    local vcd_name="$4"
    local src_files="${5:-}"
    
    echo "----------------------------------------"
    echo "Processing: ${design_name}"
    echo "----------------------------------------"
    
    if [ ! -f "${pnl_file}" ]; then
        echo "ERROR: Powered netlist not found: ${pnl_file}"
        return 1
    fi
    
    echo "  Netlist: ${pnl_file}"
    echo "  VCD output: ${SIM_OUT}/${vcd_name}.vcd"
    
    local vvp_file="${SIM_OUT}/${vcd_name}.vvp"
    
    # Build iverilog command
    local iverilog_cmd=(iverilog -g2012
        -DFUNCTIONAL
        -DUSE_POWER_PINS
        "-DUNIT_DELAY=#1"
        "-D${sim_macro}"
        -o "${vvp_file}"
    )
    
    # Add primitives and cells if available
    if [ -n "${PRIMITIVES_FILE:-}" ] && [ -f "${PRIMITIVES_FILE}" ]; then
        iverilog_cmd+=("${PRIMITIVES_FILE}")
    fi
    if [ -n "${CELLS_FILE:-}" ] && [ -f "${CELLS_FILE}" ]; then
        iverilog_cmd+=("${CELLS_FILE}")
    fi
    
    # Add source files if provided (for module dependencies)
    # Note: src_files is expected to be a space-separated list of paths
    if [ -n "${src_files}" ]; then
        # shellcheck disable=SC2086
        for sf in ${src_files}; do
            if [ -f "${sf}" ]; then
                iverilog_cmd+=("${sf}")
            fi
        done
    fi
    
    # Add netlist and testbench
    iverilog_cmd+=("${pnl_file}")
    iverilog_cmd+=("${TB_FILE}")
    
    echo "  Compiling..."
    if ! "${iverilog_cmd[@]}"; then
        echo "  ERROR: iverilog compilation failed for ${design_name}"
        return 1
    fi
    
    echo "  Simulating..."
    if ! (cd "${SIM_OUT}" && vvp -n "${vcd_name}.vvp" +vcd_file="${vcd_name}.vcd"); then
        echo "  ERROR: vvp simulation failed for ${design_name}"
        return 1
    fi
    
    if [ -f "${SIM_OUT}/${vcd_name}.vcd" ]; then
        echo "  SUCCESS: Generated ${SIM_OUT}/${vcd_name}.vcd"
    else
        echo "  WARNING: VCD file not generated"
    fi
    
    echo ""
}

# ---------------------------------------------------------------------------
# Process Reversible Adder
# ---------------------------------------------------------------------------
if [ -n "${RUN_REVERSIBLE:-}" ] && [ -d "${RUN_REVERSIBLE}" ]; then
    PNL_REVERSIBLE=$(find_pnl "${RUN_REVERSIBLE}" "reversible_wrapper")
    if [ -n "${PNL_REVERSIBLE}" ]; then
        compile_and_simulate \
            "reversible_wrapper" \
            "${PNL_REVERSIBLE}" \
            "SIM_REVERSIBLE" \
            "reversible"
    else
        echo "WARNING: Could not find powered netlist for reversible design"
    fi
else
    echo "WARNING: Reversible OpenLane run directory not found"
fi

# ---------------------------------------------------------------------------
# Process Ripple Adder
# ---------------------------------------------------------------------------
if [ -n "${RUN_RIPPLE:-}" ] && [ -d "${RUN_RIPPLE}" ]; then
    PNL_RIPPLE=$(find_pnl "${RUN_RIPPLE}" "ripple_adder_wrapper")
    if [ -n "${PNL_RIPPLE}" ]; then
        compile_and_simulate \
            "ripple_adder_wrapper" \
            "${PNL_RIPPLE}" \
            "SIM_RIPPLE" \
            "ripple"
    else
        echo "WARNING: Could not find powered netlist for ripple design"
    fi
else
    echo "WARNING: Ripple OpenLane run directory not found"
fi

# ---------------------------------------------------------------------------
# Process Carry-Select Adder
# ---------------------------------------------------------------------------
if [ -n "${RUN_CARRY_SELECT:-}" ] && [ -d "${RUN_CARRY_SELECT}" ]; then
    # Try both naming conventions
    PNL_CARRY_SELECT=""
    CARRY_SELECT_NAME=""
    
    for name in "carry_select_wrapper" "carry_select_adder_wrapper"; do
        pnl=$(find_pnl "${RUN_CARRY_SELECT}" "${name}")
        if [ -n "${pnl}" ]; then
            PNL_CARRY_SELECT="${pnl}"
            CARRY_SELECT_NAME="${name}"
            break
        fi
    done
    
    if [ -n "${PNL_CARRY_SELECT}" ]; then
        compile_and_simulate \
            "${CARRY_SELECT_NAME}" \
            "${PNL_CARRY_SELECT}" \
            "SIM_CARRY_SELECT" \
            "carry_select"
    else
        echo "WARNING: Could not find powered netlist for carry-select design"
    fi
else
    echo "WARNING: Carry-Select OpenLane run directory not found"
fi

# ---------------------------------------------------------------------------
# OpenROAD Power Analysis
# ---------------------------------------------------------------------------
echo "========================================"
echo "OpenROAD Power Analysis"
echo "========================================"

if ! command -v openroad &> /dev/null; then
    echo ""
    echo "WARNING: OpenROAD not found on PATH. Skipping power analysis."
    echo ""
    echo "To install OpenROAD:"
    echo "  - Homebrew (macOS): brew install openroad"
    echo "  - Ubuntu PPA: sudo add-apt-repository ppa:openroad/openroad && sudo apt install openroad"
    echo "  - Conda: conda install -c conda-forge openroad"
    echo "  - Docker: docker run -it openroad/openroad"
    echo ""
    echo "To verify installation: openroad -version"
    echo ""
    echo "VCD files have been generated in: ${SIM_OUT}"
    echo "You can run OpenROAD power analysis manually after installing OpenROAD."
    exit 0
fi

echo "Found OpenROAD: $(which openroad)"
openroad -version 2>/dev/null || true
echo ""

# Export variables for TCL scripts
export RUN_REVERSIBLE
export RUN_RIPPLE
export RUN_CARRY_SELECT
export SIM_OUT
export LIB_TT_LIB

# Run OpenROAD power analysis for each design
run_openroad_power() {
    local tcl_script="$1"
    local design_name="$2"
    
    if [ -f "${tcl_script}" ]; then
        echo "Running power analysis for ${design_name}..."
        if openroad -exit "${tcl_script}"; then
            echo "  SUCCESS: Power analysis complete for ${design_name}"
        else
            echo "  WARNING: Power analysis failed for ${design_name}"
        fi
    else
        echo "WARNING: TCL script not found: ${tcl_script}"
    fi
}

run_openroad_power "${SCRIPTS_DIR}/openroad_power_reversible.tcl" "reversible_wrapper"
run_openroad_power "${SCRIPTS_DIR}/openroad_power_ripple.tcl" "ripple_adder_wrapper"
run_openroad_power "${SCRIPTS_DIR}/openroad_power_carry_select.tcl" "carry_select_wrapper"

echo ""

# ---------------------------------------------------------------------------
# Parse Power Reports
# ---------------------------------------------------------------------------
echo "========================================"
echo "Generating Power Summary"
echo "========================================"

if [ -f "${SCRIPTS_DIR}/parse_power_reports.py" ]; then
    if command -v python3 &> /dev/null; then
        python3 "${SCRIPTS_DIR}/parse_power_reports.py"
        if [ -f "${SCRIPTS_DIR}/power_summary_tt_025C_1v80.csv" ]; then
            echo "Power summary generated: ${SCRIPTS_DIR}/power_summary_tt_025C_1v80.csv"
            echo ""
            cat "${SCRIPTS_DIR}/power_summary_tt_025C_1v80.csv"
        fi
    else
        echo "WARNING: python3 not found. Skipping power summary generation."
    fi
else
    echo "WARNING: parse_power_reports.py not found. Skipping power summary generation."
fi

echo ""
echo "========================================"
echo "Power Analysis Workflow Complete"
echo "========================================"
