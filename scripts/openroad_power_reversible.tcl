# openroad_power_reversible.tcl
# OpenROAD power analysis script for reversible_wrapper design
# Uses VCD-based switching activity annotation for accurate power estimation
#
# Usage:
#   openroad -exit openroad_power_reversible.tcl
#
# Prerequisites:
#   - Gate-level netlist from OpenLane synthesis
#   - VCD file from gate-level simulation (sim_out/waveform.vcd)
#   - Liberty timing libraries
#   - SPEF file from parasitic extraction (optional but recommended)
#
# Environment variables (set before running):
#   DESIGN_NAME   - Design name (default: reversible_wrapper)
#   NETLIST_FILE  - Path to gate-level Verilog netlist
#   LIBERTY_FILE  - Path to Liberty timing library
#   SPEF_FILE     - Path to SPEF file (optional)
#   VCD_FILE      - Path to VCD file (default: sim_out/waveform.vcd)
#   OUTPUT_DIR    - Directory for power reports (default: power_reports)

# Set default values for environment variables
if {![info exists env(DESIGN_NAME)]} {
    set env(DESIGN_NAME) "reversible_wrapper"
}
if {![info exists env(VCD_FILE)]} {
    set env(VCD_FILE) "sim_out/waveform.vcd"
}
if {![info exists env(OUTPUT_DIR)]} {
    set env(OUTPUT_DIR) "power_reports"
}

set design_name $env(DESIGN_NAME)
set vcd_file $env(VCD_FILE)
set output_dir $env(OUTPUT_DIR)

# Create output directory if it doesn't exist
file mkdir $output_dir

puts "========================================"
puts "Power Analysis: $design_name"
puts "VCD File: $vcd_file"
puts "========================================"

# Read the design
if {[info exists env(NETLIST_FILE)]} {
    read_verilog $env(NETLIST_FILE)
} else {
    puts "ERROR: NETLIST_FILE environment variable not set"
    exit 1
}

# Read Liberty library
if {[info exists env(LIBERTY_FILE)]} {
    read_liberty $env(LIBERTY_FILE)
} else {
    puts "ERROR: LIBERTY_FILE environment variable not set"
    exit 1
}

# Link design
link_design $design_name

# Read SPEF for accurate parasitic estimation (optional)
if {[info exists env(SPEF_FILE)] && [file exists $env(SPEF_FILE)]} {
    puts "Reading SPEF file: $env(SPEF_FILE)"
    read_spef $env(SPEF_FILE)
} else {
    puts "WARNING: No SPEF file provided - using wire load models"
}

# Read VCD file for switching activity annotation
# This is the key improvement: using actual simulation activity instead of
# estimated activity factors
if {[file exists $vcd_file]} {
    puts "Reading VCD file for activity annotation: $vcd_file"
    # Use read_vcd to annotate switching activity from simulation
    # The scope should match the DUT instance name in the testbench
    read_vcd -scope tb_common_gl/u_dut $vcd_file
    puts "VCD activity annotation complete"
} else {
    puts "ERROR: VCD file not found: $vcd_file"
    puts "Please run gate-level simulation first to generate the VCD file"
    exit 1
}

# Set clock for timing-based power analysis
# Clock period should match the simulation (25ns = 40MHz)
create_clock -name clk -period 25 [get_ports clk]

# Report power with detailed breakdown
puts ""
puts "========================================"
puts "Power Report: $design_name"
puts "========================================"

# Generate detailed power report
set power_report_file "$output_dir/${design_name}_power.rpt"
redirect $power_report_file {
    report_power -digits 6
}
puts "Detailed power report written to: $power_report_file"

# Generate hierarchical power report to identify high-power modules
set hier_power_file "$output_dir/${design_name}_power_hier.rpt"
redirect $hier_power_file {
    report_power -instances -digits 6
}
puts "Hierarchical power report written to: $hier_power_file"

# Print summary to console
puts ""
puts "Power Summary:"
report_power -digits 6

# Additional analysis for reversible design: report garbage/ancilla net activity
# This helps quantify overhead from reversible computing
puts ""
puts "========================================"
puts "Reversible Design Overhead Analysis"
puts "========================================"

# Count the number of garbage output pins
set garbage_pins [get_ports -filter "direction == output" {g_a* g_ab*}]
set num_garbage_pins [llength $garbage_pins]
puts "Number of garbage/ancilla output pins: $num_garbage_pins"

# Report power on garbage nets specifically
if {$num_garbage_pins > 0} {
    set garbage_power_file "$output_dir/${design_name}_garbage_power.rpt"
    redirect $garbage_power_file {
        puts "Power on garbage/ancilla output nets:"
        foreach pin $garbage_pins {
            puts "  Pin: [get_full_name $pin]"
        }
    }
}

puts ""
puts "Power analysis complete."
puts "Reports saved in: $output_dir"
