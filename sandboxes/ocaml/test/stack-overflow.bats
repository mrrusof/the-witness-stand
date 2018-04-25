#inline $INCLUDES_DIR/runtime-error-interpreted.bats

function input_source {
  cat <<EOF
let rec this_wont_end_well n = 
  Printf.printf "not a good idea\n";
  this_wont_end_well (n + 1) + 1
in this_wont_end_well 0;;
EOF
}

function expected_output {
  echo 'not a good idea'
}

function expected_stderr {
  echo -n 'Stack overflow during evaluation'
}

EXP_EC=2


