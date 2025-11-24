#!/bin/bash
#SBATCH --job-name=s5-solver-exp
#SBATCH -p bigbatch
#SBATCH -N 1        ## Number of nodes
#SBATCH -n 1        ## Number of cores per node

source ~/.bashrc
conda activate s5

BASE_DIR="/home/degen101/Documents/COMS4059A_Research_Project"

export PYTHONPATH=$BASE_DIR/S5PY:$PYTHONPATH

solvers=(
  "CEGARBox_S5" 
  "S5PY" 
  "LCKS5Prover"
  "S52SAT"
)

# Paths to solver executables
executables=(
  "$BASE_DIR/CEGARBox_S5/CEGARBox_S5"
  "$BASE_DIR/S5PY"
  "$BASE_DIR/LCKS5Prover/LCKS5Prover"
  "$BASE_DIR/S52SAT/S52SAT"
)

# Options per solver
options=(
  "-v" 
  "" 
  ""  
  "-nbModals 5"
)

# Patterns per solver (use {solver}, {file}, {options})
patterns=(
  "{solver} -f {file} {options}"
  "python -m s5 {file} {options}"
  "cat {file} | {solver} graph {options}"
  "{solver} {file} {options}"
)

# Input directories
input_dirs=(
    "$BASE_DIR/CEGARBox_S5/Testsets/MCNF"
    "$BASE_DIR/CEGARBox_S5/Testsets/QS5"
)

# Default limits
timeout=120
memory=32

# Loop over input dirs and solvers
for dir in "${input_dirs[@]}"; do
  for i in "${!solvers[@]}"; do
    solver="${solvers[$i]}"
    exec_path="${executables[$i]}"
    solver_opts="${options[$i]}"
    pattern="${patterns[$i]}"
    
    echo ">>> Running solver '$solver' on testset '$dir'..."

    python3 -u ${BASE_DIR}/CEGARBox_S5/Scripts/run_experiment.py \
      --solver "$exec_path" \
      --dir "$dir" \
      --pattern "$pattern" \
      --timeout "$timeout"\
      --memory "$memory"\
      --options "$solver_opts"
  done
done
