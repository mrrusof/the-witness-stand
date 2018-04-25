#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
from os import system

system("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576")
EOF
}
