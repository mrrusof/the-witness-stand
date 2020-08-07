#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import numpy as np
print(np.array([1,2,3]))
EOF
)

expected_stdout='[1 2 3]'