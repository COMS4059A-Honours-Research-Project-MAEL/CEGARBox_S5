import subprocess
import os
import json

# --- Paths Configuration ---
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOLVER_dir = os.path.abspath(os.path.join(PROJECT_ROOT, "..", "S5PY"))
PROBLEMS_ROOT = os.path.abspath(os.path.join(PROJECT_ROOT, "Tests", "Problems"))
OUTPUT_FILE = os.path.join(PROJECT_ROOT, "Tests", "ExpectedResults.json")


def run_solver(cnf_path):
    """Run the Python solver (`s5`) on a CNF file and return True (SAT) or False (UNSAT)."""
    env = os.environ.copy()
    env["PYTHONPATH"] = f"{SOLVER_dir}:{env.get('PYTHONPATH','')}"

    result = subprocess.run(
        ["python", "-m", "s5", cnf_path],
        capture_output=True,
        text=True,
        check=True,
        env=env
    )

    stdout = result.stdout
    if "s UNSATISFIABLE" in stdout:
        return False
    elif "s SATISFIABLE" in stdout:
        return True
    else:
        raise RuntimeError(f"Unexpected solver output for {cnf_path}:\n{result.stdout}")


def main():
    """Generates expected results for all problem subdirectories."""
    # The argparse part is no longer needed as we'll iterate through all subdirectories
    expected_results = {}

    for dirpath, _, filenames in os.walk(PROBLEMS_ROOT):
        # We only care about subdirectories containing problems
        if dirpath == PROBLEMS_ROOT:
            continue
        
        subdir = os.path.relpath(dirpath, PROBLEMS_ROOT)
        print(f"Processing problems in '{subdir}'...")
        
        for fname in sorted(filenames):
            if fname.endswith(".cnf.txt"):
                cnf_path = os.path.join(dirpath, fname)
                sat_result = run_solver(cnf_path)
                
                # Use a relative path as the key
                relative_path_key = os.path.join(subdir, fname)
                expected_results[relative_path_key] = sat_result
                
                print(f"  {relative_path_key}: {'SATISFIABLE' if sat_result else 'UNSATISFIABLE'}")
        print()

    with open(OUTPUT_FILE, "w") as f:
        json.dump(expected_results, f, indent=2)
    print(f"\nExpected results saved to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()