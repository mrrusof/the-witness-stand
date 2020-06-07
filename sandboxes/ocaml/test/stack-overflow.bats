#inline $INCLUDES_DIR/test-templates/run-interpreted-runtime-error.bats

source_program=$(cat <<"EOF"
let rec this_wont_end_well n = 
  Printf.printf "not a good idea\n";
  this_wont_end_well (n + 1) + 1
in this_wont_end_well 0;;
EOF
)

op_program_output='=~'
expected_program_output='not a good idea'

op_stderr='=~'
expected_stderr='Stack overflow during evaluation'

expected_exit_code=2
