import pytest
import subprocess
import os
import json

# --- Paths Configuration ---
# All paths are relative to the project root
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOLVER_BIN = os.path.join(PROJECT_ROOT, "..", "CEGARBox_S5")
PROBLEMS_ROOT = os.path.join(PROJECT_ROOT, "Problems")
EXPECTED_RESULTS_FILE = os.path.join(PROJECT_ROOT, "ExpectedResults.json")

# Load expected results once
with open(EXPECTED_RESULTS_FILE, 'r') as f:
    EXPECTED_RESULTS = json.load(f)

# --- Helper Function ---
def run_solver_behavior(cnf_path):
    """Runs the solver and returns True for SATISFIABLE, False for UNSATISFIABLE."""
    try:
        result = subprocess.run(
            [SOLVER_BIN, "-f", cnf_path],
            capture_output=True,
            text=True,
            check=True
        )
        stdout = result.stdout
        if "s UNSATISFIABLE" in stdout:
            return False
        elif "s SATISFIABLE" in stdout:
            return True
        else:
            raise RuntimeError(f"Unexpected solver output for {cnf_path}:\n{stdout}")
    except Exception as e:
        pytest.fail(f"Solver execution failed: {e}")

# --- Test Case Generation ---
def get_behavioral_test_cases():
    test_cases = []
    for dirpath, _, filenames in os.walk(PROBLEMS_ROOT):
        for fname in sorted(filenames):
            if fname.endswith(".cnf.txt"):
                file_path = os.path.join(dirpath, fname)
                rel_path = os.path.relpath(file_path, PROBLEMS_ROOT)
                
                # Check if the relative path exists as a key in the JSON
                expected_sat = EXPECTED_RESULTS.get(rel_path)
                if expected_sat is not None:
                    test_cases.append((rel_path, expected_sat))
                else:
                    print(f"DEBUG: No match in JSON for {rel_path}") # Reveals which files are being filtered out
    return test_cases

# --- Pytest Parametrized Test ---
@pytest.mark.parametrize("rel_path, expected_sat", get_behavioral_test_cases())
def test_solver_behavior(rel_path, expected_sat):
    """Test if the solver's satisfiability claim is correct."""
    cnf_path = os.path.join(PROBLEMS_ROOT, rel_path)
    actual_sat = run_solver_behavior(cnf_path)
    assert actual_sat == expected_sat, f"Test {rel_path} expected {expected_sat} but got {actual_sat}"