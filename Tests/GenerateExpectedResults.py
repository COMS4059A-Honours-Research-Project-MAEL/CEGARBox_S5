import subprocess
import os
import json
from tqdm import tqdm

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
    expected_results = {}

    # Iterate over subdirectories containing problems
    problem_subdirs = [
        dirpath for dirpath, _, _ in os.walk(PROBLEMS_ROOT) if dirpath != PROBLEMS_ROOT
    ]

    for dirpath in tqdm(problem_subdirs, desc="Problem sets"):
        subdir = os.path.relpath(dirpath, PROBLEMS_ROOT)

        cnf_files = sorted([f for f in os.listdir(dirpath) if f.endswith(".cnf.txt")])
        for fname in tqdm(cnf_files, desc=f"Problems in {subdir}", leave=False):
            cnf_path = os.path.join(dirpath, fname)
            sat_result = run_solver(cnf_path)

            relative_path_key = os.path.join(subdir, fname)
            expected_results[relative_path_key] = sat_result

    with open(OUTPUT_FILE, "w") as f:
        json.dump(expected_results, f, indent=2)

    print(f"\nExpected results saved to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
