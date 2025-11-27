#------------------------------------------------------------------------------
# OpenROAD Power Analysis Script for reversible_wrapper (DEF-based variant)
# Uses DEF for physical database instead of ODB, and VCD for switching activity
# Corner: tt_025C_1v80
#------------------------------------------------------------------------------

# Configuration - paths relative to repository root
set DESIGN_NAME "reversible_wrapper"
set RUN_DIR "openlane/reversable-openlane/runs/RUN_2025-11-05_20-20-54"

# Liberty file (user should update this path based on their volare installation)
set LIBERTY_FILE "/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

# LEF files (technology and standard cells)
# User should update these paths based on their PDK installation
set TECH_LEF "/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef"
set CELL_LEF "/Users/prahalad/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef"

# Powered netlist (used for cell definitions)
set NETLIST_FILE "${RUN_DIR}/36-openroad-resizertimingpostcts/${DESIGN_NAME}.pnl.v"

# DEF file (physical database)
set DEF_FILE "${RUN_DIR}/43-openroad-detailedrouting/${DESIGN_NAME}.def"

# SDC constraints
set SDC_FILE "${RUN_DIR}/36-openroad-resizertimingpostcts/${DESIGN_NAME}.sdc"

# VCD file from simulation
set VCD_FILE "sim_out/reversible.vcd"

# Output power report
set POWER_REPORT "power_reports/reversible_power_def.rpt"

# Check if files exist
proc check_file {filepath desc} {
    if {![file exists $filepath]} {
        puts "ERROR: $desc not found: $filepath"
        exit 1
    }
}

puts "==================================================================="
puts "OpenROAD Power Analysis for $DESIGN_NAME (DEF-based)"
puts "Corner: tt_025C_1v80"
puts "==================================================================="

# Read liberty file
check_file $LIBERTY_FILE "Liberty file"
read_liberty $LIBERTY_FILE

# Read LEF files (technology and standard cells)
check_file $TECH_LEF "Technology LEF"
read_lef $TECH_LEF

check_file $CELL_LEF "Cell LEF"
read_lef $CELL_LEF

# Read the powered gate-level netlist
check_file $NETLIST_FILE "Powered netlist"
read_verilog $NETLIST_FILE
link_design $DESIGN_NAME

# Read DEF physical database
check_file $DEF_FILE "DEF file"
read_def $DEF_FILE

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
puts $fp "Power Report for $DESIGN_NAME (DEF-based)"
puts $fp "Corner: tt_025C_1v80"
puts $fp "==================================================================="
puts $fp ""
puts $fp $power_rpt
close $fp

puts "Power report written to: $POWER_REPORT"
puts "==================================================================="

exit 0
