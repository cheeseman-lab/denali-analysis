#!/bin/bash
#SBATCH --job-name=jupyteronslurm
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=256gb
#SBATCH --partition=20
#SBATCH --output=slurm/jupyteronslurm-%j.out

# Source conda configuration (use your actual conda path)
source /home/rkern/miniconda3/etc/profile.d/conda.sh

# Before running this, install: jupyterlab, ipykernel, and register the kernel
# conda install jupyterlab ipykernel
# python -m ipykernel install --user --name brieflow_denali_analysis_new --display-name "brieflow_denali_analysis_new"

# Activate conda environment
conda activate brieflow_denali_analysis_new

# Workaround for jupyter bug
unset XDG_RUNTIME_DIR

# Start jupyter lab (note: space not hyphen)
jupyter lab \
--no-browser \
--port-retries=0 \
--ip=0.0.0.0 \
--port=`shuf -i 8900-10000 -n 1` \
--notebook-dir=/ \
--LabApp.default_url="/lab/tree/home/$(whoami)"