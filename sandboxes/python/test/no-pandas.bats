#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import pandas as pd
EOF
)

expected_exit_code=1

expected_stderr=$(cat <<"EOF"
Traceback (most recent call last):
  File "/tmp/main.py", line 1, in <module>
    import pandas as pd
ModuleNotFoundError: No module named 'pandas'
EOF
)
