#!/usr/bin/env python3
"""
Power Report Parser

Parses OpenROAD power reports and generates a CSV comparison of 
total/leakage/internal/switching power for multiple designs.

Usage:
    python parse_power_reports.py <report1> <report2> ... -o <output.csv>
    python parse_power_reports.py power_reports/*.rpt -o power_comparison.csv
"""

import argparse
import csv
import os
import re
import sys
from pathlib import Path


def extract_design_name(filepath):
    """
    Extract design name from filepath.
    
    Handles both:
    - Power report files: reversible_power.rpt -> reversible
    - OpenLane paths: .../reversable-openlane/.../power.rpt -> reversible
    """
    filepath_str = str(filepath)
    
    # Check for known design patterns in path
    if 'reversable-openlane' in filepath_str or 'reversible' in filepath_str.lower():
        return 'reversible_wrapper'
    elif 'ripple' in filepath_str.lower():
        return 'ripple_adder_wrapper'
    elif 'carry-select' in filepath_str.lower() or 'carry_select' in filepath_str.lower():
        return 'carry_select_wrapper'
    
    # Default: use filename stem
    stem = Path(filepath).stem.replace('_power', '').replace('_def', '')
    return stem if stem != 'power' else Path(filepath).parent.name


def parse_power_report(filepath):
    """
    Parse an OpenROAD power report file and extract power values.
    
    Returns a dict with:
        - design_name: Name of the design
        - internal_power: Internal power in Watts
        - switching_power: Switching power in Watts
        - leakage_power: Leakage power in Watts
        - total_power: Total power in Watts
    """
    result = {
        'design_name': extract_design_name(filepath),
        'internal_power': 0.0,
        'switching_power': 0.0,
        'leakage_power': 0.0,
        'total_power': 0.0,
        'filepath': filepath
    }
    
    try:
        with open(filepath, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Warning: File not found: {filepath}", file=sys.stderr)
        return None
    except IOError as e:
        print(f"Warning: Error reading {filepath}: {e}", file=sys.stderr)
        return None
    
    # Extract design name from report if present
    design_match = re.search(r'Power Report for (\w+)', content)
    if design_match:
        result['design_name'] = design_match.group(1)
    
    # Parse the Total line from the power report
    # Format: Total                1.382757e-04 4.359033e-05 1.811915e-09 1.818678e-04 100.0%
    # Columns: Group, Internal, Switching, Leakage, Total, Percentage
    total_pattern = r'Total\s+([\d.e+-]+)\s+([\d.e+-]+)\s+([\d.e+-]+)\s+([\d.e+-]+)'
    total_match = re.search(total_pattern, content)
    
    if total_match:
        result['internal_power'] = float(total_match.group(1))
        result['switching_power'] = float(total_match.group(2))
        result['leakage_power'] = float(total_match.group(3))
        result['total_power'] = float(total_match.group(4))
    else:
        print(f"Warning: Could not parse power values from {filepath}", file=sys.stderr)
        return None
    
    return result


def format_power(value, unit='W'):
    """Format power value in a human-readable way."""
    if value == 0:
        return f"0 {unit}"
    elif abs(value) < 1e-9:
        return f"{value * 1e12:.3f} p{unit}"
    elif abs(value) < 1e-6:
        return f"{value * 1e9:.3f} n{unit}"
    elif abs(value) < 1e-3:
        return f"{value * 1e6:.3f} u{unit}"
    elif abs(value) < 1:
        return f"{value * 1e3:.3f} m{unit}"
    else:
        return f"{value:.6f} {unit}"


def write_csv(results, output_path):
    """Write power comparison results to CSV file."""
    if not results:
        print("Error: No valid results to write", file=sys.stderr)
        return False
    
    # Create output directory if needed
    os.makedirs(os.path.dirname(output_path) if os.path.dirname(output_path) else '.', exist_ok=True)
    
    fieldnames = [
        'Design',
        'Total Power (W)',
        'Internal Power (W)',
        'Switching Power (W)',
        'Leakage Power (W)',
        'Total Power (Human)',
        'Internal Power (Human)',
        'Switching Power (Human)',
        'Leakage Power (Human)'
    ]
    
    with open(output_path, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        
        for r in results:
            writer.writerow({
                'Design': r['design_name'],
                'Total Power (W)': f"{r['total_power']:.6e}",
                'Internal Power (W)': f"{r['internal_power']:.6e}",
                'Switching Power (W)': f"{r['switching_power']:.6e}",
                'Leakage Power (W)': f"{r['leakage_power']:.6e}",
                'Total Power (Human)': format_power(r['total_power']),
                'Internal Power (Human)': format_power(r['internal_power']),
                'Switching Power (Human)': format_power(r['switching_power']),
                'Leakage Power (Human)': format_power(r['leakage_power'])
            })
    
    return True


def print_summary(results):
    """Print a summary of power comparison to stdout."""
    if not results:
        return
    
    print("\n" + "=" * 80)
    print("Power Comparison Summary")
    print("=" * 80)
    print(f"{'Design':<25} {'Total':<15} {'Internal':<15} {'Switching':<15} {'Leakage':<15}")
    print("-" * 80)
    
    for r in results:
        print(f"{r['design_name']:<25} "
              f"{format_power(r['total_power']):<15} "
              f"{format_power(r['internal_power']):<15} "
              f"{format_power(r['switching_power']):<15} "
              f"{format_power(r['leakage_power']):<15}")
    
    print("=" * 80)
    
    # Print power savings comparison if we have multiple designs
    if len(results) >= 2:
        print("\nPower Comparison (relative to first design):")
        baseline = results[0]
        for r in results[1:]:
            if baseline['total_power'] > 0:
                diff = (r['total_power'] - baseline['total_power']) / baseline['total_power'] * 100
                sign = "+" if diff > 0 else ""
                print(f"  {r['design_name']} vs {baseline['design_name']}: {sign}{diff:.2f}%")


def main():
    parser = argparse.ArgumentParser(
        description='Parse OpenROAD power reports and generate CSV comparison'
    )
    parser.add_argument(
        'reports',
        nargs='+',
        help='Power report files to parse'
    )
    parser.add_argument(
        '-o', '--output',
        default='power_comparison.csv',
        help='Output CSV file path (default: power_comparison.csv)'
    )
    parser.add_argument(
        '-q', '--quiet',
        action='store_true',
        help='Suppress summary output'
    )
    
    args = parser.parse_args()
    
    # Parse all reports
    results = []
    for report_path in args.reports:
        result = parse_power_report(report_path)
        if result:
            results.append(result)
    
    if not results:
        print("Error: No valid power reports found", file=sys.stderr)
        sys.exit(1)
    
    # Sort results by design name
    results.sort(key=lambda x: x['design_name'])
    
    # Write CSV
    if write_csv(results, args.output):
        print(f"CSV written to: {args.output}")
    else:
        sys.exit(1)
    
    # Print summary unless quiet
    if not args.quiet:
        print_summary(results)
    
    return 0


if __name__ == '__main__':
    sys.exit(main())
