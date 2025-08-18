import subprocess
import os
import json
import pytest

SOLVER_BIN = os.path.abspath(os.path.join("CEGARBox_S5"))
PROBLEM_SUBDIR = os.environ.get("PROBLEM_SUBDIR", "")
PROBLEMS_DIR = os.path.abspath(os.path.join("Tests", "Problems", PROBLEM_SUBDIR))
EXPECTED_RESULTS_FILE = os.path.join("Tests", "ExpectedResults.json")


def run_solver(cnf_path):
    """Run the solver on a CNF file and return True (SATISFIABLE) or False (UNSATISFIABLE)."""
    result = subprocess.run(
        [SOLVER_BIN, "-f", cnf_path, "-t"],
        capture_output=True,
        text=True,
        check=True
    )

    if "UNSATISFIABLE" in result.stdout.upper():
        return False
    elif "SATISFIABLE" in result.stdout.upper():
        return True
    else:
        raise RuntimeError(f"Unexpected solver output for {cnf_path}:\n{result.stdout}")


@pytest.mark.parametrize("fname,expected_sat", [
    (fname, expected_sat)
    for fname, expected_sat in json.load(open(EXPECTED_RESULTS_FILE)).items()
])
def test_cnf_solver(fname, expected_sat):
    cnf_path = os.path.join(PROBLEMS_DIR, fname)
    actual_sat = run_solver(cnf_path)
    assert actual_sat == expected_sat, f"{fname} expected {expected_sat} got {actual_sat}"
