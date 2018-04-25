#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
system 'dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576'
EOF
}
