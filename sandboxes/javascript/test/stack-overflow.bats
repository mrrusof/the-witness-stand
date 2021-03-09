#inline $INCLUDES_DIR/test-templates/run-interpreted-runtime-error.bats

interpreted_program=$(cat <<"EOF"
function this_wont_end_well(n) {
  console.log("not a good idea");
  this_wont_end_well(n + 1);
}

this_wont_end_well(0);
EOF
)

op_stdout='=~'
expected_stdout='not a good idea'

op_stderr='=~'
expected_stderr='Maximum call stack size exceeded'
