###############################################################################
# openroad_power_carry_select.tcl
#
# OpenROAD power analysis script for the carry-select adder design.
# Reads the design database, SPEF parasitics, and VCD activity file,
# then reports total power.
#
# Usage:
#   openroad -exit scripts/openroad_power_carry_select.tcl
#
# Note: Adjust lib_tt path if your volare installation differs.
###############################################################################

# ========================== Configuration ====================================

# Liberty file path for TT corner (25°C, 1.8V)
# Adjust this path to match your volare installation
set lib_tt "$::env(HOME)/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

# Repository root (relative to this script)
set script_dir [file dirname [info script]]
set repo_root [file normalize "$script_dir/.."]

# Design-specific paths
set design_name "carry_select"
set run_dir "$repo_root/openlane/conventional-carry-select-openlane/runs/RUN_2025-11-05_20-14-14"

# Input files
set odb_file "$run_dir/final/odb/carry_select_wrapper.odb"
set spef_file "$run_dir/final/spef/nom/carry_select_wrapper.nom.spef"
set vcd_file "$repo_root/sim_out/carry_select.vcd"

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
