#!/usr/bin/env python3
import json
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


SOLVED_STATUSES = {"SATISFIABLE", "UNSATISFIABLE"}
TIMEOUT_STATUSES = {"Time limit exceeded", "Timed limit exceeded"}
MEMOUT_STATUSES = {"Memory limit exceeded"}


def load_solver_results(path):
    """Load a JSON results file and return a dict with useful arrays."""
    with open(path, "r") as f:
        data = json.load(f)

    solver_name = data.get("Solver", Path(path).stem)
    times_ms = data["Time Taken"]
    resolutions = data["Resolution"]

    assert len(times_ms) == len(resolutions), "Time/Resolution length mismatch"

    solved = []
    solved_times_ms = []
    for t, r in zip(times_ms, resolutions):
        if t is None:
            solved.append(False)
            solved_times_ms.append(None)
            continue

        # treat negative times as unsolved (timeout/memout encoded as -1)
        if t < 0:
            solved.append(False)
            solved_times_ms.append(180_000)
            continue

        if r in SOLVED_STATUSES:
            solved.append(True)
            solved_times_ms.append(t)
        else:
            solved.append(False)
            solved_times_ms.append(None)

    return {
        "name": solver_name,
        "times_ms": np.array(times_ms, dtype=float),
        "resolutions": np.array(resolutions, dtype=object),
        "solved_mask": np.array(solved, dtype=bool),
        "solved_times_ms": np.array(
            [t if t is not None else np.nan for t in solved_times_ms],
            dtype=float,
        ),
    }


def average_solve_time(results):
    """Average time over solved instances (in seconds)."""
    solved_times = results["solved_times_ms"]
    solved_times = solved_times[~np.isnan(solved_times)]
    if solved_times.size == 0:
        return float("nan")
    return solved_times.mean()  # ms → s


def instances_solved_vs_time(results, time_points_s):
    """For each cutoff time (seconds), count solved instances with t <= cutoff."""
    solved_times = results["solved_times_ms"] / 1000.0  # ms → s
    counts = []
    for T in time_points_s:
        counts.append(np.sum((~np.isnan(solved_times)) & (solved_times <= T)))
    return np.array(counts, dtype=int)


def plot_instances_solved(solver_results, time_points_s):
    """Plot curves: instances solved vs CPU time."""
    plt.figure(figsize=(6, 4))

    for res in solver_results:
        counts = instances_solved_vs_time(res, time_points_s)
        plt.plot(
            time_points_s,
            counts,
            marker="o",
            label=res["name"],
        )

    plt.xscale("log")
    plt.xlabel("CPU time in seconds")
    plt.ylabel("Instances solved")
    plt.title("QS5 Benchmarks")
    plt.legend()
    plt.tight_layout()


def plot_pairwise_scatter(baseline, others):
    """
    Single log-log scatter plot.

    x-axis : baseline solver times
    y-axis : other solver times
    - If both solvers solve: use their actual times.
    - If only one solves: the non-solving solver is set to max_time.
    - If neither solves: the instance is ignored.
    """

    if not others:
        return

    # --- choose a global max time (ms) for "unsolved" points ---
    all_pos_times_ms = []

    def _positive_times_ms(res):
        t = res["times_ms"]
        return t[t > 0]

    all_pos_times_ms.append(_positive_times_ms(baseline))
    for o in others:
        all_pos_times_ms.append(_positive_times_ms(o))

    all_pos_times_ms = np.concatenate(all_pos_times_ms)
    max_time = float(all_pos_times_ms.max())  # still in ms

    fig, ax = plt.subplots(figsize=(6, 4))

    all_x = []
    all_y = []

    # different marker shapes for each solver comparison
    markers = ["o", "x", "^", "s", "D", "v", ">", "<", "P", "*"]

    for i, other in enumerate(others):
        # at least one solver solved it
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

        # where a solver did not solve, clamp to max_time
        x = np.where(baseline["solved_mask"][idx], base_times, max_time)
        y = np.where(other["solved_mask"][idx], other_times, max_time)

        all_x.append(x)
        all_y.append(y)

        ax.scatter(
            x,
            y,
            alpha=0.5,
            s=10,
            marker=markers[i % len(markers)],  # <-- different shape
            label=f"{baseline['name']} vs {other['name']}",
        )

    if not all_x:
        return

    x_all = np.concatenate(all_x)
    y_all = np.concatenate(all_y)

    # diagonal y = x
    lo = min(x_all[x_all > 0].min(), y_all[y_all > 0].min()) * 0.5
    hi = max_time * 1.1
    ax.plot([lo, hi], [lo, hi], "r-", linewidth=1)

    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set_xlabel("Time (ms)")
    ax.set_ylabel("Time (ms)")
    ax.legend()
    plt.tight_layout()



def main(paths):
    if not paths:
        print("Usage: python qs5_plots.py solver1.json solver2.json ...")
        sys.exit(1)

    solver_results = [load_solver_results(p) for p in paths]

    # Print average solve times
    print("Average solve times (over solved instances only):")
    for res in solver_results:
        avg = average_solve_time(res)
        print(f"  {res['name']}: {avg: 2f} s")

    # Plot instances-solved curves (like Extended LWB S4-Benchmarks figure)
    # You can tweak these cutoffs as needed.
    time_points_s = np.array([0.25, 0.5, 1, 2, 4, 8, 15])
    plot_instances_solved(solver_results, time_points_s)

    # Pairwise scatter plots vs CEGARBox_S5 (like the Cheetah vs ... figure)
    baseline = None
    for res in solver_results:
        if res["name"] == "CEGARBox_S5":
            baseline = res
            break
    if baseline is not None:
        others = [r for r in solver_results if r is not baseline]
        plot_pairwise_scatter(baseline, others)

    plt.show()


if __name__ == "__main__":
    main(sys.argv[1:])
