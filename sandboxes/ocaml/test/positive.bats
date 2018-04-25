#inline $INCLUDES_DIR/return-interpreted.bats

function input_source {
  cat <<EOF
Printf.printf "this is line 1\n";;
Printf.printf "this is line 2\n";;
EOF
}

function expected_output {
  echo -e "this is line 1\nthis is line 2\n"
}


