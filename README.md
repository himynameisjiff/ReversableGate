# ReversableGate

This repository contains an 8-bit reversible adder implemented with CMOS circuits, along with conventional comparator adders for reference. The design was synthesized using OpenLane and compared against classical carry-select (CSLA) and ripple-carry (RCA) adders.

## Overview

The repo appears to include:

- **Reversible adder RTL / gate-level netlists**
- **Conventional ripple-carry and carry-select adder designs**
- **Gate-level simulation testbenches**
- **OpenLane synthesis outputs and supporting scripts**
- **Power analysis workflow** for comparing the designs

## Repository Structure

- `src/` — source RTL and/or synthesized design files
- `sim/` — gate-level simulation testbenches
- `scripts/` — automation for simulation, power analysis, and report parsing
- `openlane/` — OpenLane project data and run directories

## Power Analysis Workflow

The repository includes a reusable workflow for:

1. Compiling the gate-level netlists with SKY130 primitives
2. Running simulations to generate VCD activity files
3. Running OpenROAD power analysis
4. Parsing the resulting power reports into a CSV summary

The main entry point is:

```bash
scripts/run_all.sh
```

### Prerequisites

- Icarus Verilog (`iverilog`, `vvp`)
- Python 3
- OpenROAD
- SKY130 PDK / volare installation

### Example

```bash
chmod +x scripts/run_all.sh
./scripts/run_all.sh
```

## Simulation

The common gate-level testbench is located at:

```text
sim/tb_common_gl.v
```

It supports three design targets via compile-time defines:

- `DESIGN_REVERSIBLE`
- `DESIGN_RIPPLE`
- `DESIGN_CARRY_SELECT`

## Results

The workflow generates:

- VCD waveform files in `sim_out/`
- OpenROAD power reports in `power_reports/`
- A CSV power summary in `scripts/power_summary_tt_025C_1v80.csv`

## License

Licensed under the Apache License 2.0.

## Acknowledgements

Built using OpenLane, SKY130, Icarus Verilog, and OpenROAD.