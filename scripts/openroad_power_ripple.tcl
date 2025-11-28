# openroad_power_ripple.tcl
# OpenROAD power analysis script for ripple_adder_wrapper design

# Get environment variables
set run_dir $::env(RUN_RIPPLE)
set sim_out $::env(SIM_OUT)

# Liberty file - use environment variable if set
if {[info exists ::env(LIB_TT_LIB)]} {
    set lib_file $::env(LIB_TT_LIB)
} else {
    # Fallback path (adjust as needed for your environment)
    set lib_file "$::env(HOME)/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
}

# Design name
set design_name "ripple_adder_wrapper"

# Find powered netlist - prefer final/pnl, fallback to 36-openroad-resizertimingpostcts
if {[file exists "${run_dir}/final/pnl/${design_name}.pnl.v"]} {
    set pnl_file "${run_dir}/final/pnl/${design_name}.pnl.v"
} elseif {[file exists "${run_dir}/36-openroad-resizertimingpostcts/${design_name}.pnl.v"]} {
    set pnl_file "${run_dir}/36-openroad-resizertimingpostcts/${design_name}.pnl.v"
} else {
    puts "ERROR: Could not find powered netlist for ${design_name}"
    exit 1
}

# Find ODB file - prefer final/odb
if {[file exists "${run_dir}/final/odb/${design_name}.odb"]} {
    set odb_file "${run_dir}/final/odb/${design_name}.odb"
} else {
    puts "ERROR: Could not find ODB file for ${design_name}"
    exit 1
}

# Find SDC file from 54-openroad-stapostpnr
set sdc_dir "${run_dir}/54-openroad-stapostpnr/nom_tt_025C_1v80"
if {[file exists "${sdc_dir}"]} {
    # Look for SDC file in this directory or use the final SDC
    if {[file exists "${run_dir}/final/sdc/${design_name}.sdc"]} {
        set sdc_file "${run_dir}/final/sdc/${design_name}.sdc"
    } else {
        set sdc_file ""
    }
} else {
    set sdc_file ""
}

# VCD file
set vcd_file "${sim_out}/ripple.vcd"

# Output power report
set power_report "${run_dir}/power_${design_name}_tt_025C_1v80.rpt"

puts "========================================"
puts "Power Analysis: ${design_name}"
puts "========================================"
puts "Liberty:  ${lib_file}"
puts "Netlist:  ${pnl_file}"
puts "ODB:      ${odb_file}"
puts "SDC:      ${sdc_file}"
puts "VCD:      ${vcd_file}"
puts "Report:   ${power_report}"
puts "========================================"

# Read liberty
read_liberty ${lib_file}

# Read design database
read_db ${odb_file}

# Read SDC if available
if {${sdc_file} ne "" && [file exists ${sdc_file}]} {
    read_sdc ${sdc_file}
} else {
    puts "WARNING: No SDC file found, using default constraints"
    # Create default clock constraint
    create_clock -name clk -period 10 [get_ports clk]
}

# Read VCD for switching activity
if {[file exists ${vcd_file}]} {
    read_power_activities -scope ${design_name} -vcd ${vcd_file}
} else {
    puts "WARNING: VCD file not found: ${vcd_file}"
    puts "         Using default switching activity"
    set_power_activity -global -activity 0.1
}

# Report power
puts ""
puts "Power Analysis Results:"
puts "========================================"
report_power

# Write power report to file
set fp [open ${power_report} w]
puts $fp [report_power]
close $fp

puts ""
puts "Power report written to: ${power_report}"
