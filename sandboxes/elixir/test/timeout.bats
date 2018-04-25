#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
:timer.sleep 3600000
EOF
}
