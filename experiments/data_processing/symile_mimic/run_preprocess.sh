#!/bin/bash
#SBATCH --job-name=run_preprocess
#SBATCH --output=logs/preprocess/%x_%j.out
#SBATCH --error=logs/preprocess/%x_%j.err
#SBATCH --time=48:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

module load miniconda3/23.11.0s
source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh
conda activate symile-env

python convert_to_pt.py