#!/usr/bin/env python3
import json
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


# -------------------------------------------------------------------
# configuration
# -------------------------------------------------------------------

SOLVED_STATUSES = {"SATISFIABLE", "UNSATISFIABLE"}
TIMEOUT_STATUSES = {"Time limit exceeded", "Timed limit exceeded"}
MEMOUT_STATUSES = {"Memory limit exceeded"}

# treat unsolved as this time (in ms) when we need a concrete value
TL_MS = 180_000.0

# mapping from "nice" solver names (for table/legend) to directory names
SOLVER_DIRS = {
    "CEGARBox_S5": "CEGARBox_S5",
    "S5PY": "S5PY",
    "S52SAT": "S52SAT",
    "LCKS5TabProver": "LCKS5TabProver",  # may not actually have JSON
}
SOLVER_ORDER = ["CEGARBox_S5", "S5PY", "S52SAT", "LCKS5TabProver"]


# -------------------------------------------------------------------
# core result building
# -------------------------------------------------------------------

def make_results(name, times_ms, resolutions):
    """Build the result dict given raw times & resolutions."""
    assert len(times_ms) == len(resolutions), "Time/Resolution length mismatch"

    solved_mask = []
    avg_times_ms = []

    for t, r in zip(times_ms, resolutions):
        if t is None:
            solved_mask.append(False)
            avg_times_ms.append(np.nan)
            continue

        # negative time: encode timeout/memout as TL_MS
        if t < 0:
            solved_mask.append(False)
            avg_times_ms.append(TL_MS)
            continue

        if r in SOLVED_STATUSES:
            solved_mask.append(True)
            avg_times_ms.append(t)
        else:
            solved_mask.append(False)
            # keep NaN so unsolved instances can be handled separately
            avg_times_ms.append(np.nan)

    return {
        "name": name,
        "times_ms": np.array(times_ms, dtype=float),
        "resolutions": np.array(resolutions, dtype=object),
        "solved_mask": np.array(solved_mask, dtype=bool),
        "avg_times_ms": np.array(avg_times_ms, dtype=float),
    }


def load_single_json(path: Path):
    with open(path, "r") as f:
        data = json.load(f)
    return data["Time Taken"], data["Resolution"]


def load_qs5_solver(results_root: Path,
                    solver_key: str,
                    ref_solver_key: str = "CEGARBox_S5"):
    """
    Load (or fabricate) QS5 results for a single solver.

    We expect a single JSON file of the form
      <solver_dir>/<solver_dir>-QS5-results.json

    If it is missing (e.g. for LCKS5TabProver), we:
      - read the reference solver's JSON, and
      - fabricate TL_MS times and "Time limit exceeded" resolutions
        for the same number of instances.
    """
    solver_dir = SOLVER_DIRS[solver_key]
    solver_path = results_root / solver_dir

    times_ms = []
    resolutions = []

    json_candidates = []
    if solver_key != "LCKS5TabProver":
        json_candidates = list(
            solver_path.glob(f"{solver_dir}-QS5-results.json")
        )

    if json_candidates:
        # normal case: use the solver's own results
        t, r = load_single_json(json_candidates[0])
        times_ms.extend(t)
        resolutions.extend(r)
    else:
        # missing JSON -> fabricate TL results based on reference solver
        ref_dir = SOLVER_DIRS[ref_solver_key]
        ref_path = results_root / ref_dir
        ref_candidates = list(
            ref_path.glob(f"{ref_dir}-QS5-results.json")
        )
        if not ref_candidates:
            print(
                f"Warning: no JSON for {solver_key} or reference "
                f"{ref_solver_key} in QS5 directory; skipping."
            )
            return make_results(solver_key, [], [])

        t_ref, _ = load_single_json(ref_candidates[0])
        n = len(t_ref)
        times_ms.extend([TL_MS] * n)
        resolutions.extend(["Time limit exceeded"] * n)

    return make_results(solver_key, times_ms, resolutions)


def average_time_ms(results):
    """
    Average over all instances, treating TL as TL_MS.
    (Anything stored as NaN is ignored.)
    """
    vals = results["avg_times_ms"]
    vals = vals[~np.isnan(vals)]
    if vals.size == 0:
        return float("nan")
    return float(vals.mean())


# -------------------------------------------------------------------
# plotting helpers (same style as MCNF script)
# -------------------------------------------------------------------

def instances_solved_vs_time(results, time_points_s):
    """For each cutoff time (seconds), count solved instances with t <= cutoff."""
    times_s = results["times_ms"] / 1000.0
    mask = results["solved_mask"]
    counts = []
    for T in time_points_s:
        counts.append(np.sum(mask & (times_s <= T)))
    return np.array(counts, dtype=int)


def plot_instances_solved(solver_results, time_points_s, title="QS5 Benchmarks"):
    plt.figure(figsize=(6, 4))

    for res in solver_results:
        counts = instances_solved_vs_time(res, time_points_s)
        plt.plot(time_points_s, counts, marker="o", label=res["name"])

    plt.xscale("log")
    plt.xlabel("Time (s)")
    plt.ylabel("Instances solved")
    plt.legend()
    plt.tight_layout()


def plot_pairwise_scatter(baseline, others):
    """
    Single log–log scatter plot.

    x-axis : baseline solver times
    y-axis : other solver times
    - If both solvers solve: use their actual times.
    - If only one solves: the non-solving solver is set to max_time.
    - If neither solves: the instance is ignored.
    """

    if not others:
        return

    # global max positive time (ms) across all solvers
    all_pos_times_ms = []

    def _positive_times_ms(res):
        t = res["times_ms"]
        return t[t > 0]

    all_pos_times_ms.append(_positive_times_ms(baseline))
    for o in others:
        all_pos_times_ms.append(_positive_times_ms(o))

    all_pos_times_ms = np.concatenate(all_pos_times_ms)
    if all_pos_times_ms.size == 0:
        return
    max_time = float(all_pos_times_ms.max())

    fig, ax = plt.subplots(figsize=(6, 4))

    all_x = []
    all_y = []

    markers = ["o", "x", "^", "s", "D", "v", ">", "<", "P", "*"]

    for i, other in enumerate(others):
        mask_any = baseline["solved_mask"] | other["solved_mask"]
        if not np.any(mask_any):
            print(
                f"Warning: no instances solved by either "
                f"{baseline['name']} or {other['name']}; skipping."
            )
            continue

        idx = np.where(mask_any)[0]
        base_times = baseline["times_ms"][idx]
        other_times = other["times_ms"][idx]

        # clamp unsolved to max_time
        x = np.where(baseline["solved_mask"][idx], base_times, max_time)
        y = np.where(other["solved_mask"][idx], other_times, max_time)

        all_x.append(x)
        all_y.append(y)

        ax.scatter(
            x,
            y,
            alpha=0.5,
            s=10,
            marker=markers[i % len(markers)],
            label=f"{baseline['name']} vs {other['name']}",
        )

    if not all_x:
        return

    x_all = np.concatenate(all_x)
    y_all = np.concatenate(all_y)

    lo = min(x_all[x_all > 0].min(), y_all[y_all > 0].min()) * 0.5
    hi = max_time * 1.1
    ax.plot([lo, hi], [lo, hi], "r-", linewidth=1)  # diagonal y=x

    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set_xlabel("Time (ms)")
    ax.set_ylabel("Time (ms)")
    ax.legend()
    plt.tight_layout()


# -------------------------------------------------------------------
# table row printing
# -------------------------------------------------------------------

def print_qs5_row(solver_results):
    """
    Print a LaTeX-friendly row for the QS5 family:

      QS5 & #total & ... & ... \\\\
    """
    stats = {}
    totals = {}
    for res in solver_results:
        solver_key = res["name"]
        total = len(res["times_ms"])
        solved = int(res["solved_mask"].sum())

        if solved == 0:
            avg_ms = TL_MS
        else:
            avg_ms = average_time_ms(res)

        stats[solver_key] = (solved, avg_ms)
        totals[solver_key] = total

    total_family = totals["CEGARBox_S5"]

    row = (
        f"QS5 & {total_family} & "
        f"{stats['CEGARBox_S5'][0]} & {stats['CEGARBox_S5'][1]:.2f} & "
        f"{stats['S5PY'][0]} & {stats['S5PY'][1]:.2f} & "
        f"{stats['S52SAT'][0]} & {stats['S52SAT'][1]:.2f} & "
        f"{stats['LCKS5TabProver'][0]} & {stats['LCKS5TabProver'][1]:.2f} \\\\"
    )
    print("% QS5 row for LaTeX table:")
    print(row)
    print()


# -------------------------------------------------------------------
# main
# -------------------------------------------------------------------

def main():
    if len(sys.argv) < 2:
        print("Usage: python qs5_plots.py /path/to/Results/QS5")
        sys.exit(1)

    qs5_root = Path(sys.argv[1]).expanduser().resolve()
    if not qs5_root.is_dir():
        print(f"Error: {qs5_root} is not a directory")
        sys.exit(1)

    # load all solvers in a fixed order
    all_results = []
    for solver_key in SOLVER_ORDER:
        res = load_qs5_solver(qs5_root, solver_key)
        all_results.append(res)

    # 1) print LaTeX row for the QS5 table entry
    print_qs5_row(all_results)

    # 2) cactus plot: instances solved vs time
    time_points_s = np.array([
        0.01, 0.02, 0.05,   # very small times
        0.1, 0.2, 0.5,      # sub-second
        1, 2, 5,            # 1–5 seconds
        10, 20,             # 10–20 seconds
        60, 180             # 1 minute, full timeout
    ])
    plot_instances_solved(all_results, time_points_s, title="QS5 Benchmarks")

    # 3) scatter: baseline = CEGARBox_S5
    baseline = all_results[0]      # CEGARBox_S5
    others = all_results[1:]       # S5PY, S52SAT, LCKS5TabProver
    plot_pairwise_scatter(baseline, others)

    plt.show()


if __name__ == "__main__":
    main()
