###############################################################################
# openroad_power_ripple.tcl
#
# OpenROAD power analysis script for the ripple adder design.
# Reads the design database, SPEF parasitics, and VCD activity file,
# then reports total power.
#
# Usage:
#   openroad -exit scripts/openroad_power_ripple.tcl
#
# Environment variables (optional):
#   VOLARE_ROOT - Path to volare PDK installation
#   RUN_RIPPLE  - Path to the OpenLane run directory for this design
#   VCD_FILE    - Path to VCD activity file (default: sim_out/ripple.vcd)
#
# Note: Adjust lib_tt path if your volare installation differs.
###############################################################################

# ========================== Configuration ====================================

# Liberty file path for TT corner (25°C, 1.8V)
# Use environment variable if set, otherwise use default volare path
if {[info exists ::env(VOLARE_ROOT)]} {
    set volare_root $::env(VOLARE_ROOT)
} else {
    set volare_root "$::env(HOME)/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A"
}
set lib_tt "$volare_root/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

# Repository root (relative to this script)
set script_dir [file dirname [info script]]
set repo_root [file normalize "$script_dir/.."]

# Design-specific paths
set design_name "ripple_adder_wrapper"
set TOP_MODULE "ripple_adder_wrapper"

# Use environment variable for run directory if set, otherwise find latest run
if {[info exists ::env(RUN_RIPPLE)]} {
    set run_dir $::env(RUN_RIPPLE)
} else {
    # Find the latest run directory
    set runs_base "$repo_root/openlane/conventional-ripple-openlane/runs"
    set run_dirs [glob -nocomplain -type d "$runs_base/RUN_*"]
    if {[llength $run_dirs] > 0} {
        set run_dir [lindex [lsort -decreasing $run_dirs] 0]
    } else {
        error "No run directories found in $runs_base"
    }
}

# Input files
set odb_file "$run_dir/final/odb/ripple_adder_wrapper.odb"
set spef_file "$run_dir/final/spef/nom/ripple_adder_wrapper.nom.spef"

# VCD file from simulation (can be overridden via environment)
if {[info exists ::env(VCD_FILE)]} {
    set vcd_file $::env(VCD_FILE)
} else {
    set vcd_file "$repo_root/sim_out/ripple.vcd"
}

# Output power reports
set POWER_RPT "$repo_root/power_reports/power_ripple_adder_wrapper_tt_025C_1v80.rpt"
set POWER_VERBOSE_RPT "$repo_root/power_reports/power_ripple_adder_wrapper_verbose.rpt"

# ========================== Load Design ======================================

puts "======================================================================"
puts " OpenROAD Power Analysis: $design_name"
puts "======================================================================"

# Read liberty file for timing/power characterization
puts "\nReading liberty file..."
read_liberty $lib_tt

# Read the design database (contains netlist, placement, routing)
puts "Reading design database..."
read_db $odb_file

# Link the design
link_design $TOP_MODULE

# Read parasitic extraction (SPEF)
puts "Reading SPEF parasitics..."
read_spef $spef_file

# ========================== Power Analysis ===================================

puts "\nReading VCD activity file..."
puts "  VCD: $vcd_file"

# Create output directory if needed
file mkdir [file dirname $POWER_RPT]

# Read switching activity from VCD using read_vcd
# Use -scope to specify the hierarchical path to the DUT in the VCD
# If hierarchy mismatch occurs, try adding -strip_path tb_common_gl.dut
if {[file exists $vcd_file]} {
    puts "Annotating activity from VCD..."
    # Try with the full hierarchy first
    if {[catch {read_vcd $vcd_file -scope $TOP_MODULE} err]} {
        puts "WARNING: read_vcd with -scope $TOP_MODULE failed: $err"
        puts "Trying with -scope tb_common_gl/dut..."
        if {[catch {read_vcd $vcd_file -scope tb_common_gl/dut} err2]} {
            puts "WARNING: read_vcd with -scope tb_common_gl/dut also failed: $err2"
            puts "Running power analysis without VCD activity annotation."
        }
    }
} else {
    puts "WARNING: VCD file not found: $vcd_file"
    puts "Running power analysis without switching activity data."
}

# Set default activity for unmatched pins
set_power_activity -global -activity 0.1 -duty 0.5

# Report power
puts "\n======================================================================"
puts " Power Report: $design_name"
puts "======================================================================"

# Generate verbose power report
report_power -verbose > $POWER_VERBOSE_RPT
puts "Verbose power report written to: $POWER_VERBOSE_RPT"

# Generate standard power report
report_power > $POWER_RPT
puts "Power report written to: $POWER_RPT"

# Also print to stdout
report_power

puts "\n======================================================================"
puts " Power Analysis Complete: $design_name"
puts "======================================================================"

exit 0
