import torch, numpy as np
from pathlib import Path

src = Path("/users/kmaeda2/scratch/physionet.org/files/symile-mimic/1.0.0/data_npy")
dst = src.parent / "data_pt"
dst.mkdir(exist_ok=True)

for split in ["train", "val", "val_retrieval", "test"]:
    (dst / split).mkdir(exist_ok=True)
    for f in (src / split).glob("*.npy"):
        arr = np.load(f, allow_pickle=False)
        torch.save(torch.from_numpy(arr), dst / split / f.with_suffix(".pt").name)
