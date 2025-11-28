#!/usr/bin/env python3
"""
parse_power_reports.py

Parses OpenROAD power reports and generates a CSV summary.
The script searches for power reports in the OpenLane run directories
and extracts total, leakage, internal, and switching power values.
"""

import os
import re
import csv
import sys
from pathlib import Path


def find_repo_root():
    """Find the repository root directory."""
    script_dir = Path(__file__).resolve().parent
    return script_dir.parent


def find_latest_run(design_dir):
    """Find the latest run directory for a design."""
    runs_dir = design_dir / "runs"
    if not runs_dir.exists():
        return None
    
    run_dirs = sorted(runs_dir.glob("RUN_*"), reverse=True)
    if run_dirs:
        return run_dirs[0]
    return None


def parse_power_report(report_path):
    """
    Parse an OpenROAD power report and extract power values.
    
    Returns a dict with keys: total, leakage, internal, switching
    Values are in watts (or original units from report).
    """
    power_data = {
        "total": None,
        "leakage": None,
        "internal": None,
        "switching": None,
    }
    
    if not os.path.exists(report_path):
        return power_data
    
    with open(report_path, "r") as f:
        content = f.read()
    
    # OpenROAD power report format patterns
    # Pattern for "Total Power: X.XXX W" or similar
    patterns = {
        "total": [
            r"Total\s+Power[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
            r"Total[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
        ],
        "leakage": [
            r"Leakage\s+Power[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
            r"Leakage[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
        ],
        "internal": [
            r"Internal\s+Power[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
            r"Internal[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
        ],
        "switching": [
            r"Switching\s+Power[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
            r"Switching[:\s]+([0-9.eE+-]+)\s*(W|mW|uW|nW)?",
        ],
    }
    
    def normalize_power(value, unit):
        """Convert power to watts."""
        if value is None:
            return None
        try:
            val = float(value)
            if unit:
                unit = unit.lower()
                if unit == "mw":
                    val *= 1e-3
                elif unit == "uw":
                    val *= 1e-6
                elif unit == "nw":
                    val *= 1e-9
            return val
        except (ValueError, TypeError):
            return None
    
    for power_type, pattern_list in patterns.items():
        for pattern in pattern_list:
            match = re.search(pattern, content, re.IGNORECASE)
            if match:
                value = match.group(1)
                unit = match.group(2) if len(match.groups()) > 1 else None
                power_data[power_type] = normalize_power(value, unit)
                break
    
    return power_data


def main():
    """Main function to parse all power reports and generate CSV."""
    repo_root = find_repo_root()
    scripts_dir = repo_root / "scripts"
    openlane_dir = repo_root / "openlane"
    
    # Define designs to process
    designs = [
        {
            "name": "reversible_wrapper",
            "dir": openlane_dir / "reversable-openlane",
            "report_pattern": "power_reversible_wrapper_tt_025C_1v80.rpt",
            "env_var": "RUN_REVERSIBLE",
        },
        {
            "name": "ripple_adder_wrapper",
            "dir": openlane_dir / "conventional-ripple-openlane",
            "report_pattern": "power_ripple_adder_wrapper_tt_025C_1v80.rpt",
            "env_var": "RUN_RIPPLE",
        },
        {
            "name": "carry_select_wrapper",
            "dir": openlane_dir / "conventional-carry-select-openlane",
            "report_pattern": "power_carry_select*_tt_025C_1v80.rpt",
            "env_var": "RUN_CARRY_SELECT",
        },
    ]
    
    results = []
    
    for design in designs:
        run_dir = None
        
        # Check for environment variable override (using explicit mapping)
        env_var_name = design.get("env_var", "")
        if env_var_name and env_var_name in os.environ:
            run_dir = Path(os.environ[env_var_name])
        else:
            run_dir = find_latest_run(design["dir"])
        
        if not run_dir or not run_dir.exists():
            print(f"WARNING: Run directory not found for {design['name']}")
            continue
        
        # Find power report
        report_path = None
        if "*" in design["report_pattern"]:
            # Glob pattern
            matches = list(run_dir.glob(design["report_pattern"]))
            if matches:
                report_path = matches[0]
        else:
            report_path = run_dir / design["report_pattern"]
        
        if report_path and report_path.exists():
            power_data = parse_power_report(report_path)
            results.append({
                "design": design["name"],
                "total_power_W": power_data["total"],
                "leakage_power_W": power_data["leakage"],
                "internal_power_W": power_data["internal"],
                "switching_power_W": power_data["switching"],
                "report_path": str(report_path),
            })
            print(f"Parsed: {report_path}")
        else:
            print(f"WARNING: Power report not found for {design['name']}")
            results.append({
                "design": design["name"],
                "total_power_W": None,
                "leakage_power_W": None,
                "internal_power_W": None,
                "switching_power_W": None,
                "report_path": "NOT FOUND",
            })
    
    # Write CSV
    csv_path = scripts_dir / "power_summary_tt_025C_1v80.csv"
    
    if results:
        fieldnames = [
            "design",
            "total_power_W",
            "leakage_power_W",
            "internal_power_W",
            "switching_power_W",
            "report_path",
        ]
        
        with open(csv_path, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(results)
        
        print(f"\nPower summary written to: {csv_path}")
    else:
        print("\nNo power reports found to summarize.")
        return 1
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
