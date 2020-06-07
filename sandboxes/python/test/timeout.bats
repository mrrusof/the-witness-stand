#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

source_program=$(cat <<"EOF"
from time import sleep

sleep(3600)
EOF
)
