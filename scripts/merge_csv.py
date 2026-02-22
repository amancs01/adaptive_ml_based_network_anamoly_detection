

import pandas as pd
import glob
import os

files = glob.glob(os.path.join("data", "flows_*.csv"))
if not files:
    raise SystemExit("No files found matching data/flows_*.csv")

dfs = [pd.read_csv(f) for f in files]
final_df = pd.concat(dfs, ignore_index=True)

out_path = os.path.join("data", "flows_all.csv")
final_df.to_csv(out_path, index=False)

print(f"Merged {len(files)} files -> {out_path} ({len(final_df)} rows)")