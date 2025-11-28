# Power Measurement Workflow

This directory contains scripts and tools for accurate power analysis of the
reversible and conventional adder designs.

## Overview

The power measurement workflow consists of three main steps:

1. **Gate-level simulation** - Generate VCD files with switching activity
2. **Power analysis** - Use OpenROAD to compute power from VCD activity
3. **Metrics computation** - Parse reports and compute normalized energy metrics

## Directory Structure

```
sim/
  tb_common_gl.v       - Common gate-level testbench with VCD dumping
scripts/
  openroad_power_reversible.tcl    - Power analysis for reversible_wrapper
  openroad_power_ripple.tcl        - Power analysis for ripple_adder_wrapper  
  openroad_power_carry_select.tcl  - Power analysis for carry_select_wrapper
  parse_power.py                   - Power report parser with energy metrics
```

## Quick Start

### 1. Run Gate-Level Simulation

First, compile and run the testbench with the appropriate DUT selection:

```bash
# Create output directory
mkdir -p sim_out

# For reversible adder
iverilog -DDUT_REVERSIBLE -o sim_out/reversible_gl \
    -I src/reversable \
    sim/tb_common_gl.v \
    path/to/reversible_wrapper_netlist.v

vvp sim_out/reversible_gl

# For ripple adder
iverilog -DDUT_RIPPLE -o sim_out/ripple_gl \
    -I src/conventional-ripple \
    sim/tb_common_gl.v \
    path/to/ripple_adder_wrapper_netlist.v

vvp sim_out/ripple_gl

# For carry-select adder
iverilog -DDUT_CARRY_SELECT -o sim_out/carry_select_gl \
    -I src/conventional-carry-select \
    sim/tb_common_gl.v \
    path/to/carry_select_wrapper_netlist.v

vvp sim_out/carry_select_gl
```

### 2. Run Power Analysis

Use OpenROAD to analyze power from the VCD files:

```bash
# Set environment variables
export NETLIST_FILE=path/to/netlist.v
export LIBERTY_FILE=path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
export SPEF_FILE=path/to/design.spef  # optional but recommended
export VCD_FILE=sim_out/waveform.vcd
export OUTPUT_DIR=power_reports

# Run OpenROAD power analysis
openroad -exit scripts/openroad_power_reversible.tcl
openroad -exit scripts/openroad_power_ripple.tcl
openroad -exit scripts/openroad_power_carry_select.tcl
```

### 3. Parse Results and Compare

Use the Python parser to extract and compare power metrics:

```bash
# Single design analysis
python3 scripts/parse_power.py power_reports/reversible_wrapper_power.rpt

# Compare all designs
python3 scripts/parse_power.py --compare \
    power_reports/reversible_wrapper_power.rpt \
    power_reports/ripple_adder_wrapper_power.rpt \
    power_reports/carry_select_wrapper_power.rpt

# Export as JSON
python3 scripts/parse_power.py --json power_reports/reversible_wrapper_power.rpt

# Export as CSV
python3 scripts/parse_power.py --csv --compare \
    power_reports/*.rpt > power_comparison.csv
```

## VCD Dump Depth Control

The testbench supports configurable VCD dump depth to balance simulation
accuracy vs. file size:

| Define | Description | VCD Size Impact |
|--------|-------------|-----------------|
| (default) | DUT top-level pins only | Small |
| `DUMP_DEPTH2` | 2 levels of hierarchy | Medium |
| `DUMP_ALL` | All internal signals | Very Large |

**Warning**: Using `DUMP_ALL` can produce VCD files of 100s of MB to GB for
longer simulations. Only use when analyzing detailed internal switching.

Example with increased dump depth:

```bash
iverilog -DDUT_REVERSIBLE -DDUMP_DEPTH2 -o sim_out/reversible_gl ...
```

## Normalized Energy Metrics

The `parse_power.py` script computes several normalized metrics for fair
comparison:

- **Energy per addition (pJ)**: Total energy divided by number of add operations
- **Energy per sum bit (pJ)**: Energy per bit of output produced
- **Energy per toggle (pJ)**: Energy per estimated input transition
- **Clock vs Logic split (%)**: Breakdown of where energy is consumed
- **Annotation coverage (%)**: Fraction of pins with VCD activity data

## Reversible Design Overhead

The reversible adder has additional overhead due to:

1. **Garbage outputs**: The `g_a` and `g_ab` signals toggle but produce no
   useful computation, consuming extra switching power.

2. **Ancilla inputs**: The `anc` inputs must be driven and held at zero,
   adding loading capacitance.

The power scripts specifically track these overhead sources to help quantify
the cost of reversibility.

### Reducing Overhead

Consider these techniques to reduce reversible design power:

1. **Clock gating**: Disable clock to output registers when garbage signals
   are not needed.

2. **Ancilla optimization**: Use optimized ancilla initialization circuits.

3. **Uncomputation**: Implement proper reversible uncomputation to reuse
   garbage signals, reducing total switching activity.

## Troubleshooting

### "Annotated 0 pin activities"

This error indicates the VCD file was not read correctly. Check:

1. VCD file exists at the expected path (`sim_out/waveform.vcd`)
2. VCD scope matches DUT instance name (`tb_common_gl/u_dut`)
3. Signal names in VCD match the netlist

### Large VCD files

If VCD files are too large:

1. Reduce simulation length (fewer additions)
2. Use default dump depth instead of `DUMP_ALL`
3. Compress VCD files: `gzip sim_out/waveform.vcd`

### Missing power breakdown

If power reports don't show clock/logic breakdown:

1. Ensure clock constraints are set (`create_clock` in Tcl script)
2. Check that sequential and combinational cells are recognized
3. Verify Liberty library is loaded correctly

## References

- [OpenROAD Power Analysis](https://openroad.readthedocs.io/en/latest/user/PowerAnalysis.html)
- [VCD File Format](https://en.wikipedia.org/wiki/Value_change_dump)
- [OpenLane Power Report](https://openlane.readthedocs.io/en/latest/reference/power_report.html)
