import json
import os
from tqdm import tqdm

BASE_PATH = os.path.dirname(os.path.abspath(__file__))
OUTPUT_PATH = os.path.join(BASE_PATH, "Configs")
os.makedirs(OUTPUT_PATH, exist_ok=True)

def main():
    num_problems = 10
    num_boxes = 1
    max_depths = [2, 4, 6]
    num_clauses = [30, 60, 90, 120, 150]
    num_literals = [3, 4, 5, 6, 7, 8]

    # Templates for C and p by depth
    C_templates = {
        2: [
            [0, 2, 2],
            [1, 2],
            [1]
        ],
        4: [
            [0, 3, 3],
            [1, 2, 3],
            [1, 2],
            [1, 1],
            [1]
        ],
        6: [
            [0, 3, 4],
            [1, 3],
            [2, 3],
            [1, 2],
            [1, 1],
            [1],
            [1]
        ]
    }

    p_templates = {
        2: [
            [ [], [3, 1], [2, 1, 1] ],
            [ [1, 2], [1, 1, 1] ],
            [ [3, 1] ]
        ],
        4: [
            [ [], [2, 1], [2, 2, 1] ],
            [ [1, 1], [1, 2, 1], [0, 1, 1] ],
            [ [1, 2], [1, 1, 1]],
            [ [2, 1], [1, 2, 1] ],
            [ [3, 1] ]
        ],
        6: [
            [ [], [2, 2], [1, 2, 1] ],
            [ [1, 1], [1, 2, 1] ],
            [ [1, 2], [1, 1, 1] ],
            [ [2, 1], [1, 1, 1] ],
            [ [2, 1], [1, 2, 1]],
            [ [3, 1] ],
            [ [4, 1] ]
        ]
    }


    total = len(max_depths) * len(num_clauses) * len(num_literals)

    with tqdm(total=total, desc="Generating configs") as pbar:
        for depth in max_depths:
            for num_clause in num_clauses:
                for num_literal in num_literals:
                    config_file = f"MCNF_{depth}_{num_boxes}_{num_clause}_{num_literal}.json"
                    config_path = os.path.join(OUTPUT_PATH, config_file)

                    data = {
                        "num_problems": num_problems,
                        "max_depth": depth,
                        "num_boxes": num_boxes,
                        "num_clauses": num_clause,
                        "num_vars": num_literal,
                        "C": C_templates[depth],
                        "p": p_templates[depth]
                    }

                    with open(config_path, "w") as file:
                        json.dump(data, file, ensure_ascii=False, indent=4)

                    pbar.update(1)


if __name__ == "__main__":
    main()
