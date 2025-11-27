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
# User should update this path based on their volare installation
SKY130_LIB_DIR="/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd"
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
