#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
from time import sleep

sleep(3600)
EOF
}
