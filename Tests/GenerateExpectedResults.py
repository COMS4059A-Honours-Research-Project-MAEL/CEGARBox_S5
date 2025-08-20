import subprocess
import os
import json
import argparse

# Path to S5 Solver
SOLVER_dir = os.path.abspath(os.path.join("..", "S5PY"))

# Output file for baseline results
OUTPUT_FILE = os.path.join("Tests", "ExpectedResults.json")


def run_solver(cnf_path):
    """Run the Python solver (`s5`) on a CNF file and return True (SATISFIABLE) or False (UNSATISFIABLE)."""
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
    parser = argparse.ArgumentParser(description="Generate ExpectedResults.json for CNF problems")
    parser.add_argument(
        "-s", "--subdir",
        default="",
        help="Problem subdirectory (Small, Medium, Large)"
    )
    args = parser.parse_args()

    problems_dir = os.path.abspath(os.path.join("Tests", "Problems", args.subdir))
    expected_results = {}

    for fname in sorted(os.listdir(problems_dir)):
        if fname.endswith(".cnf.txt"):
            cnf_path = os.path.join(problems_dir, fname)
            sat_result = run_solver(cnf_path)
            expected_results[fname] = sat_result
            print(f"{fname}: {'SATISFIABLE' if sat_result else 'UNSATISFIABLE'}")

    with open(OUTPUT_FILE, "w") as f:
        json.dump(expected_results, f, indent=2)
    print(f"\nExpected results saved to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
