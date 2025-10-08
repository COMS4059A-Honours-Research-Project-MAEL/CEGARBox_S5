import subprocess
import os

# Path to the MDK Verifier binary
MDK_VERIFIER_BIN = os.path.abspath(os.path.join(os.path.dirname(__file__), "mdk-verifier-linux"))

def verify_model(model_str, formula_path):
    """
    Verifies a model against a formula file using the MDK Verifier binary.
    """
    try:
        # Pass the formula file path to the verifier
        process = subprocess.run(
            [MDK_VERIFIER_BIN, formula_path],
            input=model_str,
            capture_output=True,
            text=True,
            check=True
        )
        # MDK-Verifier outputs "OK" for a valid model
        return "ok" in process.stdout.lower()
    except FileNotFoundError:
        print(f"Error: MDK Verifier binary not found at {MDK_VERIFIER_BIN}")
        return False
    except subprocess.CalledProcessError as e:
        print(f"MDK Verifier error for formula file '{formula_path}': {e.stderr}")
        return False