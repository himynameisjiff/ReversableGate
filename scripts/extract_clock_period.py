#!/usr/bin/env python3
"""
extract_clock_period.py

Utility to extract clock period from an SDC (Synopsys Design Constraints) file.

Usage:
    python3 scripts/extract_clock_period.py <sdc_file>

Outputs the clock period in nanoseconds to stdout.

Example:
    CLOCK_PERIOD_NS=$(python3 scripts/extract_clock_period.py design.sdc)
"""

import re
import sys


def extract_clock_period(sdc_path: str) -> float:
    """
    Parse an SDC file and extract the clock period from the first create_clock command.
    
    Args:
        sdc_path: Path to the SDC file
        
    Returns:
        Clock period in nanoseconds
        
    Raises:
        ValueError: If no create_clock command is found
        FileNotFoundError: If the SDC file doesn't exist
    """
    with open(sdc_path, 'r') as f:
        text = f.read()
    
    # Match create_clock -period <number> or create_clock ... -period <number>
    # Pattern handles various formats:
    #   create_clock -period 25 ...
    #   create_clock -name clk -period 25.0 ...
    #   create_clock [get_ports clk] -period 10.5 ...
    match = re.search(r'create_clock\s+[^;]*-period\s+(\d+\.?\d*)', text)
    
    if not match:
        raise ValueError(f"Could not find clock period in {sdc_path}")
    
    return float(match.group(1))


def main():
    if len(sys.argv) < 2:
        print("Usage: extract_clock_period.py <sdc_file>", file=sys.stderr)
        print("  Extracts clock period (ns) from SDC file's create_clock command.", file=sys.stderr)
        sys.exit(1)
    
    sdc_path = sys.argv[1]
    
    try:
        period = extract_clock_period(sdc_path)
        print(period)
    except FileNotFoundError:
        print(f"ERROR: SDC file not found: {sdc_path}", file=sys.stderr)
        sys.exit(2)
    except ValueError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        sys.exit(3)


if __name__ == '__main__':
    main()
