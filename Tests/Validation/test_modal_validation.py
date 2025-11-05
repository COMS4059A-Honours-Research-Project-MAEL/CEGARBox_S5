import pytest
import subprocess
import os
import json
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))

from Tests.Verifier.verifier_bridge import verify_model

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
def run_solver_and_get_model(cnf_path):
    """Runs the solver and returns the model string if satisfiable."""
    try:
        result = subprocess.run(
            [SOLVER_BIN, "-f", cnf_path, "-m"],
            capture_output=True,
            text=True,
            check=True
        )
        stdout = result.stdout
        if "s SATISFIABLE" in stdout:
            return stdout
        return None
    except Exception as e:
        pytest.fail(f"Solver execution failed: {e}")

# --- Test Case Generation ---
def get_validation_test_cases():
    """Generates test cases for satisfiable problems only."""
    test_cases = []
    for dirpath, _, filenames in os.walk(PROBLEMS_ROOT):
        for fname in sorted(filenames):
            if fname.endswith(".cnf.txt"):
                rel_path = os.path.relpath(os.path.join(dirpath, fname), PROBLEMS_ROOT)
                expected_sat = EXPECTED_RESULTS.get(rel_path)
                if expected_sat:
                    test_cases.append(rel_path)
    return test_cases

# --- Pytest Parametrized Test ---
@pytest.mark.parametrize("rel_path", get_validation_test_cases())
def test_model_validation(rel_path):
    """
    Tests if the model produced by the solver is correct for satisfiable problems.
    """
    cnf_path = os.path.join(PROBLEMS_ROOT, rel_path)

    # Display the file currently being tested
    print(f"\033[94mTesting file:\033[0m '{cnf_path}'")
    sys.stdout.flush()  # Ensure output shows immediately even if pytest buffers

    # Run the solver to get the model
    model_str = run_solver_and_get_model(cnf_path)
    
    if model_str is None:
        pytest.fail(f"Solver did not produce a model for satisfiable problem '{cnf_path}'")
    
    # Verify the model using the CNF file as the formula file
    is_model_correct = verify_model(model_str, cnf_path)
    
    assert is_model_correct, f"Solver produced an incorrect model for '{cnf_path}'"
