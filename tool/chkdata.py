import pyarrow.parquet as pq
import sys
import numpy as np
#import polars as pl

file = sys.argv[1];
table = pq.read_table(file)
df=table.to_pandas()
if len(sys.argv) > 2:
  keys = sys.argv[2].split(' ')
  df = df[keys]
  for k in keys:
    adf = df[k];
    v = set(np.array(adf).flatten().tolist())
    print(k,v)

df.info()
print(df)



#df=pl.read_parquet(file)
#print(df)
