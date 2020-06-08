#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
from os import system

system("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576")
EOF
)
