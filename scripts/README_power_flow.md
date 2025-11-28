# Power Analysis Workflow

This document describes the end-to-end workflow for generating gate-level switching activity and running OpenROAD post-route power analysis for the three adder designs:

1. **Reversible Wrapper** (`reversible_wrapper`) - 8-bit reversible ripple adder
2. **Ripple Adder Wrapper** (`ripple_adder_wrapper`) - 8-bit conventional ripple adder
3. **Carry-Select Adder Wrapper** (`carry_select_wrapper`) - 8-bit conventional carry-select adder

## Prerequisites

- **Icarus Verilog**: For gate-level simulation (`iverilog`, `vvp`)
- **OpenROAD**: For power analysis
- **Python 3**: For parsing power reports
- **Sky130 PDK**: Standard cell library (volare-managed or custom installation)

### Installing Prerequisites

```bash
# Ubuntu/Debian
sudo apt-get install iverilog

# macOS (Homebrew)
brew install icarus-verilog

# OpenROAD - Follow official installation guide:
# https://openroad.readthedocs.io/en/latest/user/Build.html

# Python 3 is typically pre-installed
```

## Directory Structure

```
ReversableGate/
├── sim/
│   └── tb_common_gl.v          # Common gate-level testbench
├── scripts/
│   ├── run_all.sh              # Main workflow script
│   ├── openroad_power_reversible.tcl
│   ├── openroad_power_ripple.tcl
│   ├── openroad_power_carry_select.tcl
│   ├── openroad_power_reversible_def.tcl  # DEF-based variant
│   ├── parse_power_reports.py  # Power report parser
│   └── README_power_flow.md    # This file
├── sim_out/                    # Simulation output (generated)
│   ├── reversible.vcd
│   ├── ripple.vcd
│   └── carry_select.vcd
└── power_reports/              # Power analysis output (generated)
    ├── reversible_power.rpt
    ├── ripple_power.rpt
    ├── carry_select_power.rpt
    └── power_comparison.csv
```

## Quick Start

### Run the Complete Workflow

```bash
# From the repository root
chmod +x scripts/run_all.sh
./scripts/run_all.sh
```

This will:
1. Compile and run gate-level simulations for all three designs
2. Generate VCD files with switching activity
3. Run OpenROAD power analysis for each design
4. Parse power reports and generate a CSV comparison

### Run Individual Steps

```bash
# Only run simulations
./scripts/run_all.sh --sim-only

# Only run power analysis (requires VCD files)
./scripts/run_all.sh --power-only

# Only parse existing power reports
./scripts/run_all.sh --parse-only
```

## Configuration

### Environment Variables

The scripts support the following environment variables:

| Variable | Description |
|----------|-------------|
| `PDK_ROOT` | Root directory of the Sky130 PDK (e.g., `/path/to/sky130A`) |
| `SKY130_LIB_DIR` | Direct path to `sky130_fd_sc_hd` library directory |
| `LIBERTY_FILE` | Full path to the liberty file (`.lib`) |
| `TECH_LEF` | Full path to the technology LEF file (for DEF-based flow) |
| `CELL_LEF` | Full path to the cell LEF file (for DEF-based flow) |

Example usage:
```bash
# Using PDK_ROOT
export PDK_ROOT=/path/to/sky130A
./scripts/run_all.sh

# Or using SKY130_LIB_DIR directly
export SKY130_LIB_DIR=/path/to/sky130_fd_sc_hd
./scripts/run_all.sh

# For OpenROAD scripts
export LIBERTY_FILE=/path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
openroad -exit scripts/openroad_power_reversible.tcl
```

### Liberty File Path

The OpenROAD scripts support environment variables with fallback to default paths.
Common locations:
- volare: `~/.volare/volare/sky130/versions/<version>/sky130A/libs.ref/sky130_fd_sc_hd/lib/`
- OpenLane: `$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/`

### Sky130 Verilog Models

Set `SKY130_LIB_DIR` environment variable or update the default in `run_all.sh`:

```bash
export SKY130_LIB_DIR="/path/to/sky130A/libs.ref/sky130_fd_sc_hd"
```

## Manual Steps

### 1. Gate-Level Simulation

Run simulations individually using Icarus Verilog:

```bash
mkdir -p sim_out

# Reversible adder
iverilog -g2012 \
    -DDESIGN_REVERSIBLE \
    -DVCD_FILE=\"sim_out/reversible.vcd\" \
    -I/path/to/sky130_fd_sc_hd/verilog \
    /path/to/sky130_fd_sc_hd.v \
    openlane/reversable-openlane/runs/RUN_2025-11-05_20-20-54/36-openroad-resizertimingpostcts/reversible_wrapper.pnl.v \
    sim/tb_common_gl.v \
    -o sim_out/reversible_sim

vvp sim_out/reversible_sim

# Ripple adder
iverilog -g2012 \
    -DDESIGN_RIPPLE \
    -DVCD_FILE=\"sim_out/ripple.vcd\" \
    -I/path/to/sky130_fd_sc_hd/verilog \
    /path/to/sky130_fd_sc_hd.v \
    openlane/conventional-ripple-openlane/runs/RUN_2025-11-05_20-17-51/36-openroad-resizertimingpostcts/ripple_adder_wrapper.pnl.v \
    sim/tb_common_gl.v \
    -o sim_out/ripple_sim

vvp sim_out/ripple_sim

# Carry-select adder
iverilog -g2012 \
    -DDESIGN_CARRY_SELECT \
    -DVCD_FILE=\"sim_out/carry_select.vcd\" \
    -I/path/to/sky130_fd_sc_hd/verilog \
    /path/to/sky130_fd_sc_hd.v \
    openlane/conventional-carry-select-openlane/runs/RUN_2025-11-05_20-14-14/36-openroad-resizertimingpostcts/carry_select_wrapper.pnl.v \
    sim/tb_common_gl.v \
    -o sim_out/carry_select_sim

vvp sim_out/carry_select_sim
```

### 2. OpenROAD Power Analysis

Run power analysis scripts individually:

```bash
mkdir -p power_reports

# From repository root
openroad -exit scripts/openroad_power_reversible.tcl
openroad -exit scripts/openroad_power_ripple.tcl
openroad -exit scripts/openroad_power_carry_select.tcl
```

### 3. Parse Power Reports

```bash
python3 scripts/parse_power_reports.py \
    power_reports/reversible_power.rpt \
    power_reports/ripple_power.rpt \
    power_reports/carry_select_power.rpt \
    -o power_reports/power_comparison.csv
```

## Testbench Details

The testbench (`sim/tb_common_gl.v`) provides:

- **Clock**: 40 MHz (25 ns period) matching SDC constraints
- **Test Pattern**: LFSR-based pseudo-random inputs for 1024 cycles
- **Signals**:
  - Reset held for 4 cycles
  - Enable (where applicable) asserted after reset
  - Random a, b, cin values driven each cycle
  - Ancilla (anc) held at zero for reversible design

The testbench uses compile-time defines:
- `-DDESIGN_REVERSIBLE`: For reversible_wrapper
- `-DDESIGN_RIPPLE`: For ripple_adder_wrapper
- `-DDESIGN_CARRY_SELECT`: For carry_select_wrapper
- `-DVCD_FILE="path"`: Output VCD file path

## Power Report Format

The OpenROAD power reports contain hierarchical power breakdown:

```
Group                    Internal    Switching      Leakage        Total
                            Power        Power        Power        Power (Watts)
------------------------------------------------------------------------
Sequential           ...
Combinational        ...
Clock                ...
------------------------------------------------------------------------
Total                ...
```

The CSV comparison includes:
- Design name
- Total, Internal, Switching, and Leakage power (in Watts)
- Human-readable power values (in uW, mW, etc.)

## Troubleshooting

### "Liberty file not found"
Update the `LIBERTY_FILE` path in the OpenROAD TCL scripts to match your PDK installation.

### "Sky130 Verilog models not found"
Update `SKY130_LIB_DIR` in `run_all.sh` to point to your Sky130 installation.

### "iverilog: command not found"
Install Icarus Verilog or add it to your PATH.

### "openroad: command not found"
Install OpenROAD or add it to your PATH.

### Simulation errors
Check the compile and simulation logs in `sim_out/` for detailed error messages.

## Design Interfaces

### reversible_wrapper
```verilog
module reversible_wrapper (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire [7:0]  anc,
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout,
    output reg  [7:0]  g_a,
    output reg  [7:0]  g_ab
);
```

### ripple_adder_wrapper
```verilog
module ripple_adder_wrapper (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout
);
```

### carry_select_wrapper
```verilog
module carry_select_wrapper (
    input  wire        clk,
    input  wire        reset,
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout
);
```

Note: `carry_select_wrapper` does not have an `enable` port; inputs are sampled every clock cycle.

## Files Reference

| File | Description |
|------|-------------|
| `sim/tb_common_gl.v` | Common gate-level testbench |
| `scripts/run_all.sh` | Main workflow script |
| `scripts/openroad_power_reversible.tcl` | Power analysis for reversible_wrapper |
| `scripts/openroad_power_ripple.tcl` | Power analysis for ripple_adder_wrapper |
| `scripts/openroad_power_carry_select.tcl` | Power analysis for carry_select_wrapper |
| `scripts/openroad_power_reversible_def.tcl` | DEF-based power analysis variant |
| `scripts/parse_power_reports.py` | Power report parser |
