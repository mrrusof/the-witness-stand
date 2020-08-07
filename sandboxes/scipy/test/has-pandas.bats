#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import pandas as pd
from io import StringIO

TESTDATA = StringIO("""col1;col2;col3
    1;4.4;99
    """)

df = pd.read_csv(TESTDATA, sep=';')

print(df)
EOF
)

expected_stdout=$(cat <<"EOF"
   col1  col2  col3
0     1   4.4    99
EOF
)
