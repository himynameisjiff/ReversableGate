# Power Comparison Workflow for SKY130 Gate-Level Designs

This document explains how to run the power comparison workflow for the three adder implementations (reversible, ripple, and carry-select) synthesized with OpenLane for the SKY130 process.

## Overview

The workflow performs:
1. **Gate-level simulation** using Icarus Verilog to generate VCD (Value Change Dump) waveforms
2. **Power analysis** using OpenROAD with activity from VCDs
3. **Report parsing** to generate a summary CSV comparing power across designs

## Prerequisites

### Icarus Verilog

Icarus Verilog (`iverilog` and `vvp`) is required for gate-level simulation.

**Installation:**
```bash
# macOS
brew install icarus-verilog

# Ubuntu/Debian
sudo apt-get install iverilog

# Conda (cross-platform)
conda install -c conda-forge iverilog
```

### OpenROAD

OpenROAD is required for power analysis.

**Installation options:**

```bash
# Homebrew (macOS)
brew install openroad

# Ubuntu PPA
sudo add-apt-repository ppa:openroad/openroad
sudo apt-get update
sudo apt-get install openroad

# Conda (cross-platform)
conda install -c conda-forge openroad

# Docker
docker pull openroad/openroad
# Then run scripts inside the container
```

**Verify installation:**
```bash
openroad -version
```

### SKY130 PDK (via volare)

The workflow requires the SKY130 PDK installed via volare, specifically:
- **Primitives**: `sky130_fd_sc_hd__primitives.v` or `primitives.v`
- **Cell models**: `sky130_fd_sc_hd.v`
- **Liberty file**: `sky130_fd_sc_hd__tt_025C_1v80.lib`

If your volare install is in a non-default location, set the `VOLARE_ROOT` environment variable:
```bash
export VOLARE_ROOT=/path/to/your/volare/sky130/versions/<hash>/sky130A
```

## Running the Workflow

```bash
chmod +x scripts/run_all.sh
scripts/run_all.sh
```

The script will:
1. Check all dependencies
2. Compile gate-level netlists with SKY130 primitives
3. Run simulations to generate VCDs
4. Run OpenROAD power analysis
5. Parse reports into `scripts/power_summary_tt_025C_1v80.csv`

## Output Files

| File | Description |
|------|-------------|
| `sim_out/reversible.vcd` | VCD waveform for reversible adder |
| `sim_out/ripple.vcd` | VCD waveform for ripple adder |
| `sim_out/carry_select.vcd` | VCD waveform for carry-select adder |
| `scripts/reversible_power_report.txt` | OpenROAD power report |
| `scripts/ripple_power_report.txt` | OpenROAD power report |
| `scripts/carry_select_power_report.txt` | OpenROAD power report |
| `scripts/power_summary_tt_025C_1v80.csv` | Summary CSV with power comparison |

## Troubleshooting

### Icarus Verilog: CLK_delayed / D_delayed errors

**Problem:** Icarus Verilog fails with errors about undefined signals like `CLK_delayed`, `D_delayed`, or timing-check constructs.

**Cause:** The SKY130 cell models contain Verilog timing constructs (`specify` blocks, `$setup`, `$hold`, etc.) that reference internal delayed signals. These are only meaningful for timing simulation, not functional simulation.

**Solution:** The workflow uses `-DFUNCTIONAL` to disable timing constructs:
```bash
iverilog -DFUNCTIONAL ...
```

This preprocessor define is already included in `run_all.sh`. If you're compiling manually, ensure you include it.

### Icarus Verilog: Undefined primitive errors

**Problem:** Errors about undefined primitives like `sky130_fd_sc_hd__udp_pwrgood_pp$PG`.

**Cause:** The gate-level netlist uses SKY130 primitives that must be included before the cell models.

**Solution:** Ensure primitives are compiled first:
```bash
iverilog \
    -DFUNCTIONAL \
    $VOLARE_ROOT/libs.ref/sky130_fd_sc_hd/verilog/primitives.v \
    $VOLARE_ROOT/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v \
    <netlist.pnl.v> \
    <testbench.v>
```

The primitives file may be named `primitives.v` or `sky130_fd_sc_hd__primitives.v` depending on your volare version.

### OpenROAD: Liberty file not found

**Problem:** OpenROAD fails to load the liberty file.

**Cause:** The path to the liberty file in the TCL scripts doesn't match your volare installation.

**Solution:** Edit the `lib_tt` variable in each TCL script:
```tcl
# scripts/openroad_power_*.tcl
set lib_tt "/your/path/to/sky130_fd_sc_hd__tt_025C_1v80.lib"
```

Or set `VOLARE_ROOT` before running:
```bash
export VOLARE_ROOT=/your/volare/path/sky130A
scripts/run_all.sh
```

### OpenROAD: Command not found

**Problem:** `openroad: command not found`

**Solution:** Install OpenROAD using one of the methods in the Prerequisites section. Verify installation:
```bash
which openroad
openroad -version
```

If using Docker:
```bash
docker run -v $(pwd):/work -w /work openroad/openroad scripts/run_all.sh
```

### VCD file not generated

**Problem:** Simulation completes but VCD file is missing or empty.

**Cause:** The testbench may not have the correct `$dumpfile` path or `$dumpvars` call.

**Solution:** The testbench `sim/tb_common_gl.v` uses a compile-time define for the VCD path:
```verilog
`ifdef VCD_FILE
    $dumpfile(`VCD_FILE);
`else
    $dumpfile("dump.vcd");
`endif
```

The `run_all.sh` script passes `-DVCD_FILE="..."` during compilation.

### Power report parsing errors

**Problem:** `parse_power_reports.py` fails or produces empty CSV.

**Cause:** The power report format may differ from expected, or reports are missing.

**Solution:** 
1. Check that all power reports exist in `scripts/`
2. Examine the report format and update `parse_power_reports.py` regex patterns if needed
3. Run manually to see errors:
   ```bash
   python3 scripts/parse_power_reports.py
   ```

## Customization

### Using a Different Simulator

The workflow is designed for Icarus Verilog. For other simulators:

**VCS:**
```bash
vcs -full64 +define+FUNCTIONAL +v2k \
    $SKY130_PRIMITIVES $SKY130_CELLS <netlist.pnl.v> <testbench.v>
./simv
```

**Verilator (waveforms only):**
```bash
verilator --cc --trace +define+FUNCTIONAL \
    $SKY130_PRIMITIVES $SKY130_CELLS <netlist.pnl.v> <testbench.v>
```

### Changing the Process Corner

The default flow uses TT (typical-typical) corner at 25°C, 1.8V. To use different corners:

1. Update `LIB_TT` in `run_all.sh` to point to the appropriate liberty file
2. Update `lib_tt` in the TCL scripts
3. Rename output CSV accordingly

Available corners in SKY130:
- `sky130_fd_sc_hd__tt_025C_1v80.lib` - Typical, 25°C
- `sky130_fd_sc_hd__ff_n40C_1v95.lib` - Fast-fast, -40°C
- `sky130_fd_sc_hd__ss_100C_1v60.lib` - Slow-slow, 100°C

## File Structure

```
ReversableGate/
├── scripts/
│   ├── run_all.sh                      # Main workflow script
│   ├── README_power_flow.md            # This documentation
│   ├── openroad_power_reversible.tcl   # OpenROAD power script
│   ├── openroad_power_ripple.tcl       # OpenROAD power script
│   ├── openroad_power_carry_select.tcl # OpenROAD power script
│   ├── parse_power_reports.py          # Report parser
│   └── power_summary_tt_025C_1v80.csv  # Generated summary
├── sim/
│   └── tb_common_gl.v                  # Gate-level testbench
├── sim_out/
│   ├── reversible.vcd                  # Generated VCD
│   ├── ripple.vcd                      # Generated VCD
│   └── carry_select.vcd                # Generated VCD
└── openlane/
    ├── reversable-openlane/runs/.../final/
    │   ├── pnl/reversible_wrapper.pnl.v
    │   ├── odb/reversible_wrapper.odb
    │   └── spef/nom/reversible_wrapper.nom.spef
    ├── conventional-ripple-openlane/runs/.../final/
    │   └── ...
    └── conventional-carry-select-openlane/runs/.../final/
        └── ...
```

## References

- [OpenROAD Documentation](https://openroad.readthedocs.io/)
- [SKY130 PDK Documentation](https://skywater-pdk.readthedocs.io/)
- [Icarus Verilog Manual](https://iverilog.fandom.com/wiki/Main_Page)
- [volare PDK Manager](https://github.com/efabless/volare)
