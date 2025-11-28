#!/usr/bin/env python3
"""
parse_power_reports.py

Parses OpenROAD power reports and generates a summary CSV with normalized
energy metrics.

Usage:
    python3 scripts/parse_power_reports.py \\
        --clock-period-ns 25 --bit-width 8 --out scripts/power_summary_tt_025C_1v80.csv \\
        power_reversible_wrapper_tt_025C_1v80.rpt \\
        power_ripple_adder_wrapper_tt_025C_1v80.rpt \\
        power_carry_select_wrapper_tt_025C_1v80.rpt

Output CSV columns:
    design, total_power_W, leakage_power_W, internal_power_W, switching_power_W,
    dynamic_power_W, energy_per_op_J, energy_per_bit_J, dynamic_energy_per_op_J,
    dynamic_energy_per_bit_J, report_path
"""

import re
import csv
import argparse
import pathlib
import sys

# Pre-compiled regex for matching Total line in power reports.
# Defined at module level for efficiency (compiled once) and clarity.
TOTAL_LINE_RE = re.compile(r'^\s*Total\s+')


def parse_report(path: pathlib.Path):
    """
    Parse an OpenROAD power report and extract power values.
    
    Looks for the first line beginning with 'Total' and extracts:
    Internal, Switching, Leakage, Total power values.
    
    Returns:
        Tuple of (internal, switching, leakage, total) as strings, or None if not found.
    """
    try:
        text = path.read_text(errors='ignore')
    except (FileNotFoundError, IOError) as e:
        print(f"WARNING: Cannot read file {path}: {e}", file=sys.stderr)
        return None

    for line in text.splitlines():
        if TOTAL_LINE_RE.match(line):
            toks = line.split()
            # Expect: Total <Internal> <Switching> <Leakage> <Total> [Percent]
            if len(toks) >= 5:
                internal, switching, leakage, total = toks[1], toks[2], toks[3], toks[4]
                return internal, switching, leakage, total
    return None


def extract_design_name(stem: str) -> str:
    """
    Extract design name from report filename stem.
    
    Strips leading 'power_' and trailing corner suffix (e.g., '_tt_025C_1v80').
    """
    design = re.sub(r'^power_', '', stem)
    design = re.sub(r'_tt_\d+C_\d+v\d+$', '', design)
    return design


def main():
    ap = argparse.ArgumentParser(
        description="Parse OpenROAD power reports and output normalized CSV."
    )
    ap.add_argument(
        '--clock-period-ns',
        type=float,
        required=True,
        help='Clock period (ns) for energy normalization'
    )
    ap.add_argument(
        '--bit-width',
        type=int,
        required=True,
        help='Data path bit width (e.g., 8)'
    )
    ap.add_argument(
        '--out',
        type=str,
        required=True,
        help='Output CSV path'
    )
    ap.add_argument(
        'reports',
        nargs='+',
        help='Power report file paths'
    )
    args = ap.parse_args()

    rows = []
    T = args.clock_period_ns * 1e-9  # Convert ns to seconds

    for rpt in args.reports:
        p = pathlib.Path(rpt)
        parsed = parse_report(p)
        if not parsed:
            print(f"WARNING: Could not parse: {p}", file=sys.stderr)
            continue
        
        internal_s, switching_s, leakage_s, total_s = parsed
        try:
            internal = float(internal_s)
            switching = float(switching_s)
            leakage = float(leakage_s)
            total = float(total_s)
        except ValueError:
            print(f"WARNING: Non-numeric values in {p}", file=sys.stderr)
            continue

        # Compute derived metrics
        dynamic = internal + switching
        e_op = total * T
        e_bit = e_op / args.bit_width
        dyn_e_op = dynamic * T
        dyn_e_bit = dyn_e_op / args.bit_width

        design = extract_design_name(p.stem)

        rows.append({
            'design': design,
            'total_power_W': f"{total:.6e}",
            'leakage_power_W': f"{leakage:.6e}",
            'internal_power_W': f"{internal:.6e}",
            'switching_power_W': f"{switching:.6e}",
            'dynamic_power_W': f"{dynamic:.6e}",
            'energy_per_op_J': f"{e_op:.6e}",
            'energy_per_bit_J': f"{e_bit:.6e}",
            'dynamic_energy_per_op_J': f"{dyn_e_op:.6e}",
            'dynamic_energy_per_bit_J': f"{dyn_e_bit:.6e}",
            'report_path': str(p)
        })

    header = [
        'design', 'total_power_W', 'leakage_power_W', 'internal_power_W',
        'switching_power_W', 'dynamic_power_W', 'energy_per_op_J',
        'energy_per_bit_J', 'dynamic_energy_per_op_J', 'dynamic_energy_per_bit_J',
        'report_path'
    ]
    out_path = pathlib.Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)

    with out_path.open('w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=header)
        w.writeheader()
        w.writerows(rows)

    print(f"CSV written to: {out_path}")

    # Print summary
    if rows:
        print("\nPower Summary:")
        print("-" * 100)
        print(f"{'Design':<30} {'Total (W)':<15} {'Dynamic (W)':<15} {'Leakage (W)':<15} {'Energy/Op (J)':<15}")
        print("-" * 100)
        for row in rows:
            print(f"{row['design']:<30} {row['total_power_W']:<15} {row['dynamic_power_W']:<15} "
                  f"{row['leakage_power_W']:<15} {row['energy_per_op_J']:<15}")
        print("-" * 100)
    else:
        print("ERROR: No rows parsed. Check report formats and paths.", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
