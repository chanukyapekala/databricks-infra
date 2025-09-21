import pandas as pd
from pathlib import Path

course_dir = Path.cwd().parent.parent
data_path = course_dir / "datasets"

test_data_path = data_path / "test.csv"
df = pd.read_csv(test_data_path.as_posix())
print(df.head())
