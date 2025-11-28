# Power Analysis Workflow

This directory contains scripts for running an end-to-end, reproducible power analysis workflow for the reversible and conventional adder designs.

## Overview

The power analysis workflow:
1. Compiles gate-level netlists using Icarus Verilog
2. Runs simulation to generate VCD files with switching activity
3. Uses OpenROAD to perform power analysis using the VCDs
4. Parses the power reports into a summary CSV

## Prerequisites

### Icarus Verilog

Icarus Verilog is required for gate-level simulation.

**Installation:**
- **macOS (Homebrew):** `brew install icarus-verilog`
- **Ubuntu/Debian:** `sudo apt install iverilog`
- **Fedora:** `sudo dnf install iverilog`

### Sky130 PDK

The Sky130 PDK must be installed via [volare](https://github.com/efabless/volare).

The script auto-detects the PDK in these locations:
- `$HOME/.volare`
- `/opt/volare`

Or set `VOLARE_ROOT` environment variable to your volare installation.

### OpenROAD (Optional)

OpenROAD is required for power analysis. If not installed, the script will generate VCDs and provide installation instructions.

**Installation options:**

1. **Homebrew (macOS):**
   ```bash
   brew install openroad
   ```

2. **Ubuntu PPA:**
   ```bash
   sudo add-apt-repository ppa:openroad/openroad
   sudo apt update
   sudo apt install openroad
   ```

3. **Conda:**
   ```bash
   conda install -c conda-forge openroad
   ```

4. **Docker:**
   ```bash
   docker run -it openroad/openroad
   ```

5. **OpenLane Nix Shell:**
   ```bash
   nix-shell /path/to/openlane/shell.nix --run "./scripts/run_all.sh"
   ```

**Verify installation:**
```bash
openroad -version
```

## Usage

### Basic Usage

```bash
chmod +x scripts/run_all.sh
./scripts/run_all.sh
```

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VOLARE_ROOT` | Path to volare PDK installation | Auto-detected (`$HOME/.volare`) |
| `LIB_TT_LIB` | Path to liberty file for power analysis | Auto-detected from volare |
| `RUN_REVERSIBLE` | Path to reversible design OpenLane run | Latest run in `openlane/reversable-openlane/runs/` |
| `RUN_RIPPLE` | Path to ripple adder OpenLane run | Latest run in `openlane/conventional-ripple-openlane/runs/` |
| `RUN_CARRY_SELECT` | Path to carry-select OpenLane run | Latest run in `openlane/conventional-carry-select-openlane/runs/` |

### Example with Custom Paths

```bash
export VOLARE_ROOT=/opt/volare
export LIB_TT_LIB=/path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
./scripts/run_all.sh
```

## Output Files

### VCD Files

Generated in `sim_out/`:
- `sim_out/reversible.vcd`
- `sim_out/ripple.vcd`
- `sim_out/carry_select.vcd`

### Power Reports

Generated in each design's run directory:
- `openlane/reversable-openlane/runs/RUN_*/power_reversible_wrapper_tt_025C_1v80.rpt`
- `openlane/conventional-ripple-openlane/runs/RUN_*/power_ripple_adder_wrapper_tt_025C_1v80.rpt`
- `openlane/conventional-carry-select-openlane/runs/RUN_*/power_carry_select_*_tt_025C_1v80.rpt`

### Power Summary

CSV summary of all designs:
- `scripts/power_summary_tt_025C_1v80.csv`

## Troubleshooting

### "No design selected" Error

Ensure the testbench uses `SIM_*` defines to select the DUT. The script passes:
- `-DSIM_REVERSIBLE` for reversible design
- `-DSIM_RIPPLE` for ripple adder design
- `-DSIM_CARRY_SELECT` for carry-select design

### Missing Sky130 Primitives

Include both Sky130 Verilog model files in iverilog:
1. `sky130_fd_sc_hd__primitives.v` (or `primitives.v`)
2. `sky130_fd_sc_hd.v`

The script auto-detects these files from your volare installation.

### VPWR/VGND Port Errors

Use `-DFUNCTIONAL` and `-DUSE_POWER_PINS` defines when compiling:
```bash
iverilog -DFUNCTIONAL -DUSE_POWER_PINS -DUNIT_DELAY='#1' ...
```

### Liberty File Not Found

Set `LIB_TT_LIB` to point to your liberty file:
```bash
export LIB_TT_LIB=/path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### OpenROAD Not Found

The script will print installation instructions if OpenROAD is not on PATH. VCD generation will still complete successfully.

### Carry-Select Naming Ambiguity

The script tries both `carry_select_wrapper` and `carry_select_adder_wrapper` module names automatically.

## Files

| File | Description |
|------|-------------|
| `run_all.sh` | Main script for end-to-end power analysis |
| `openroad_power_reversible.tcl` | OpenROAD TCL script for reversible design |
| `openroad_power_ripple.tcl` | OpenROAD TCL script for ripple design |
| `openroad_power_carry_select.tcl` | OpenROAD TCL script for carry-select design |
| `parse_power_reports.py` | Python script to parse power reports into CSV |
| `README_power_flow.md` | This documentation file |

## Testbench

The testbench at `sim/tb_common_gl.v` uses `SIM_*` defines to select the design under test:

```verilog
`ifdef SIM_REVERSIBLE
    // Instantiate reversible_wrapper
`elsif SIM_RIPPLE
    // Instantiate ripple_adder_wrapper
`elsif SIM_CARRY_SELECT
    // Instantiate carry_select_wrapper
`else
    initial begin
        $display("ERROR: No design selected. Use -DSIM_REVERSIBLE, -DSIM_RIPPLE, or -DSIM_CARRY_SELECT");
        $finish;
    end
`endif
```
