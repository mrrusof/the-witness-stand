#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
#load "unix.cma";;
Unix.sleep 3600;;
EOF
}
