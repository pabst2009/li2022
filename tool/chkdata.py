import pyarrow.parquet as pq
import sys

file = sys.argv[1];
table = pq.read_table(file)
df=table.to_pandas()

df.info()
