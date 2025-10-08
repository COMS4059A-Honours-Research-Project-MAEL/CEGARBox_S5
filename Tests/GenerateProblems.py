import json
import os
from random import seed
from tqdm import tqdm

from modal_cnf_library import rnd_CNF

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CONFIGS_DIR = os.path.join(PROJECT_ROOT, "Tests", "Configs")
PROBLEMS_DIR = os.path.join(PROJECT_ROOT, "Tests", "Problems")

seed(42)

def generate_modal_cnf_problems(outdir: str, file_path: str):

    with open(file_path) as f:
        config = json.load(f)

    os.makedirs(outdir, exist_ok=True)

    for i in tqdm(range(1, config["num_problems"] + 1), desc=f"Problems ({os.path.basename(file_path)})", leave=False):
        formula = rnd_CNF(
            max_d=config["max_depth"],
            m=config["num_boxes"],
            L=config["num_clauses"],
            N=config["num_vars"],
            p=config["p"],
            C=config["C"]
        )

        outfile = os.path.join(outdir, f"problem_{i:03d}.cnf.txt")
        with open(outfile, "w") as f:
            f.write(f"begin {str(formula)} end\n")


def main():
    config_files = []
    for dirpath, _, filenames in os.walk(CONFIGS_DIR):
        for fname in sorted(filenames):
            if fname.endswith(".json"):
                config_files.append(os.path.join(dirpath, fname))

    for file_path in tqdm(config_files, desc="Configs"):
        outdir = os.path.join(PROBLEMS_DIR, os.path.splitext(os.path.basename(file_path))[0])
        generate_modal_cnf_problems(outdir, file_path)


if __name__ == "__main__":
    main()
