#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import numpy as np
from scipy import linalg

a = np.array([[1, 2], [3, 4]])
d = linalg.det(a)
print(d)
EOF
)

expected_stdout='-2.0'