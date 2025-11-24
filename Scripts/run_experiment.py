import subprocess
import resource
import argparse
import os
import sys
import re
import json

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def limit_memory(max_mem_gb: int):
    """Set memory limit (in GB)."""
    soft, hard = max_mem_gb * 1024**3, max_mem_gb * 1024**3
    resource.setrlimit(resource.RLIMIT_AS, (soft, hard))


def natural_key(path: str):
    return [int(text) if text.isdigit() else text for text in re.split(r'(\d+)', path)]


def run_solver(cmd, timeout_s: int, memory_gb: int):
    try:
        result = subprocess.run(
            cmd,
            preexec_fn=lambda: limit_memory(memory_gb),
            timeout=timeout_s,
            capture_output=True,
            text=True,
            shell=True
        )
        return result.stdout

    except subprocess.TimeoutExpired:
        return "Timed limit exceeded"
    
    except MemoryError:
        return "Memory limit exceeded"
    
    except Exception as e:
        print(f"Error running solver: {e}")
        sys.exit(1)


def get_time(output: str):
    patterns = [
        r'Solving Time\(ms\):\s*([0-9]*\.?[0-9]+)',
        r'Total_time\(ms\):\s*([0-9]*\.?[0-9]+)',
        r'SOLVE TIME:\s*([0-9]*\.?[0-9]+)\s*ms?',
    ]
    
    for pattern in patterns:
        match = re.search(pattern, output)
        if match:
            return float(match.group(1))
    return None


if __name__ == "__main__":
    DEFAULT_TIME_LIMIT = 300
    DEFAULT_MEMORY_LIMIT = 64
    DEFAULT_OUTPUT_DIR = "../Results"

    parser = argparse.ArgumentParser(description="Run solver with time and memory limits")
    parser.add_argument("--solver", required=True, help="Path to solver executable")
    parser.add_argument("--dir", required=True, help="Input files directory")
    parser.add_argument("--options", nargs=argparse.REMAINDER, help="Additional solver options")
    parser.add_argument("--pattern", default="{solver} {file} {options}",
                        help="Command pattern. Use {solver}, {file}, {options}")
    parser.add_argument("--timeout", type=int, default=DEFAULT_TIME_LIMIT, help="Time limit in seconds (default 300)")
    parser.add_argument("--memory", type=int, default=DEFAULT_MEMORY_LIMIT, help="Memory limit in GB (default 64)")
    parser.add_argument("--output", type=str, default=DEFAULT_OUTPUT_DIR, help="Output directory for results")
    args = parser.parse_args()

    # Build command list from pattern
    options_str = " ".join(args.options) if args.options else ""

    for dirpath, _, filenames in sorted(os.walk(args.dir), key=lambda x: natural_key(x[0])):
        if not any([filename.endswith(".intohylo") for filename in filenames]): continue

        if dirpath[-1] == "/":
            dirpath = dirpath[:-1]

        results = {
            "Solver": args.solver.split("/")[-1],
            "Problem Set": dirpath.split("/")[-1],
            "Total Problems": 0,
            "Problems Solved": 0,
            "Time Taken": [],
            "Resolution": []
        }

        for filename in sorted(filenames):
            if not filename.endswith(".intohylo"): continue

            file_dir = os.path.join(dirpath, filename)
            cmd_str = args.pattern.format(solver=args.solver, file=file_dir, options=options_str)

            result = run_solver(cmd_str, args.timeout, args.memory)

            if "Timed limit exceeded" in result or "Memory limit exceeded" in result:
                results["Time Taken"].append(-1)
                results["Resolution"].append(result)
            else:
                results["Problems Solved"] += 1
                results["Resolution"].append("SATISFIABLE" if "s SATISFIABLE" in result else "UNSATISFIABLE")
                results["Time Taken"].append(get_time(result))
              
            results["Total Problems"] += 1

        outdir = os.path.join(BASE_DIR, args.output, results["Problem Set"], results["Solver"])
        os.makedirs(outdir, exist_ok=True)

        outfile = os.path.join(outdir, f"{results['Solver']}-{results['Problem Set']}-results.json")

        with open(outfile, "w") as f:
            json.dump(results, f, indent=4)
