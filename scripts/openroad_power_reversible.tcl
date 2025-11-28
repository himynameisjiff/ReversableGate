###############################################################################
# openroad_power_reversible.tcl
#
# OpenROAD power analysis script for the reversible adder design.
# Reads the design database, SPEF parasitics, and VCD activity file,
# then reports total power.
#
# Usage:
#   openroad -exit scripts/openroad_power_reversible.tcl
#
# Environment variables (optional):
#   VOLARE_ROOT    - Path to volare PDK installation
#   RUN_REVERSIBLE - Path to the OpenLane run directory for this design
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
set design_name "reversible"

# Use environment variable for run directory if set, otherwise find latest run
if {[info exists ::env(RUN_REVERSIBLE)]} {
    set run_dir $::env(RUN_REVERSIBLE)
} else {
    # Find the latest run directory
    set runs_base "$repo_root/openlane/reversable-openlane/runs"
    set run_dirs [glob -nocomplain -type d "$runs_base/RUN_*"]
    if {[llength $run_dirs] > 0} {
        set run_dir [lindex [lsort -decreasing $run_dirs] 0]
    } else {
        error "No run directories found in $runs_base"
    }
}

# Input files
set odb_file "$run_dir/final/odb/reversible_wrapper.odb"
set spef_file "$run_dir/final/spef/nom/reversible_wrapper.nom.spef"
set vcd_file "$repo_root/sim_out/reversible.vcd"

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

# Read parasitic extraction (SPEF)
puts "Reading SPEF parasitics..."
read_spef $spef_file

# ========================== Power Analysis ===================================

puts "\nReading VCD activity file..."
puts "  VCD: $vcd_file"

# Read switching activity from VCD
# The VCD was generated from gate-level simulation
read_power_activities -scope tb_common_gl/dut -vcd $vcd_file

# Set process corner conditions
set_power_activity -global -activity 0.1 -duty 0.5

# Report power
puts "\n======================================================================"
puts " Power Report: $design_name"
puts "======================================================================"

report_power

puts "\n======================================================================"
puts " Power Analysis Complete: $design_name"
puts "======================================================================"
#------------------------------------------------------------------------------
# OpenROAD Power Analysis Script for reversible_wrapper
# Uses ODB for physical database and VCD for switching activity
# Corner: tt_025C_1v80
#------------------------------------------------------------------------------

# Configuration - paths relative to repository root
set DESIGN_NAME "reversible_wrapper"
set RUN_DIR "openlane/reversable-openlane/runs/RUN_2025-11-05_20-20-54"

# Liberty file path
# Set LIBERTY_FILE environment variable or update the default path below
# Common locations:
#   volare: ~/.volare/volare/sky130/versions/<version>/sky130A/libs.ref/sky130_fd_sc_hd/lib/
#   OpenLane: $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/
if {[info exists ::env(LIBERTY_FILE)]} {
    set LIBERTY_FILE $::env(LIBERTY_FILE)
} elseif {[info exists ::env(PDK_ROOT)]} {
    set LIBERTY_FILE "$::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
} else {
    set LIBERTY_FILE "/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
}

# Powered netlist (used for cell definitions)
set NETLIST_FILE "${RUN_DIR}/36-openroad-resizertimingpostcts/${DESIGN_NAME}.pnl.v"

# ODB file (physical database)
set ODB_FILE "${RUN_DIR}/52-odb-cellfrequencytables/${DESIGN_NAME}.odb"

# SDC constraints
set SDC_FILE "${RUN_DIR}/36-openroad-resizertimingpostcts/${DESIGN_NAME}.sdc"

# VCD file from simulation
set VCD_FILE "sim_out/reversible.vcd"

# Output power report
set POWER_REPORT "power_reports/reversible_power.rpt"

# Check if files exist
proc check_file {filepath desc} {
    if {![file exists $filepath]} {
        puts "ERROR: $desc not found: $filepath"
        exit 1
    }
}

puts "==================================================================="
puts "OpenROAD Power Analysis for $DESIGN_NAME"
puts "Corner: tt_025C_1v80"
puts "==================================================================="

# Read liberty file
check_file $LIBERTY_FILE "Liberty file"
read_liberty $LIBERTY_FILE

# Read the physical database from ODB
check_file $ODB_FILE "ODB file"
read_db $ODB_FILE

# Read the powered gate-level netlist
check_file $NETLIST_FILE "Powered netlist"
read_verilog $NETLIST_FILE
link_design $DESIGN_NAME

# Read SDC timing constraints
check_file $SDC_FILE "SDC file"
read_sdc $SDC_FILE

# Read VCD switching activity
if {[file exists $VCD_FILE]} {
    puts "Reading VCD file: $VCD_FILE"
    read_power_activities -scope tb_common_gl/dut -vcd $VCD_FILE
} else {
    puts "WARNING: VCD file not found: $VCD_FILE"
    puts "Running power analysis without switching activity data."
}

# Create output directory
file mkdir [file dirname $POWER_REPORT]

# Generate power report
puts "Generating power report..."
set power_rpt [report_power -corner nom_tt_025C_1v80]

# Write power report to file
set fp [open $POWER_REPORT w]
puts $fp "==================================================================="
puts $fp "Power Report for $DESIGN_NAME"
puts $fp "Corner: tt_025C_1v80"
puts $fp "==================================================================="
puts $fp ""
puts $fp $power_rpt
close $fp

puts "Power report written to: $POWER_REPORT"
puts "==================================================================="

exit 0
