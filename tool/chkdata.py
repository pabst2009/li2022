import pyarrow.parquet as pq
import sys
#import polars as pl

file = sys.argv[1];
table = pq.read_table(file)
df=table.to_pandas()
if len(sys.argv) > 2:
  keys = sys.argv[2].split(' ')
  df = df[keys]

df.info()
print(df)

#df=pl.read_parquet(file)
#print(df)
