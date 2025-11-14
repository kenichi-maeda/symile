#!/bin/bash
#SBATCH --job-name=run_symile
#SBATCH --partition=gpu
#SBATCH --output=logs/pretrain/output_vit_v1_%j.log
#SBATCH --error=logs/pretrain/error_vit_v1_%j.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --time=45:00:00
#SBATCH --mem=32G

module avail hpcx-mpi

module load miniconda3/23.11.0s
source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh
conda activate symile-env

module load cudnn cuda
python -c "import torch; print('cuda available:', torch.cuda.is_available()); print('cuda version', torch.version.cuda)"

python main.py \
  --experiment symile_mimic \
  --data_dir /oscar/scratch/kmaeda2/physionet.org/files/symile-mimic/1.0.0/data_pt \
  --ckpt_save_dir /oscar/scratch/kmaeda2/symile_CP \
  --d 768 \
  --batch_sz_train 32 \
  --batch_sz_val 256 \
  --batch_sz_test 256 \
  --epochs 80 \
  --lr 3e-5 \
  --weight_decay 0.01 \
  --negative_sampling n \
  --loss_fn symile \
  --logit_scale_init 2.65926 \
  --check_val_every_n_epoch 1 \
  --drop_last True \
  --use_seed True --seed 0 \
  --pretrained False \
  --cxr_weights_path /oscar/scratch/kmaeda2/symile_CP/mae_cxr_final.ckpt

