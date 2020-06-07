#inline $INCLUDES_DIR/test-templates/run-interpreted-runtime-error.bats

source_program=$(cat <<"EOF"
def this_wont_end_well(n):
  print("not a good idea")
  this_wont_end_well(n + 1)

this_wont_end_well(0)
EOF
)

op_program_output='=~'
expected_program_output='not a good idea'

op_stderr='=~'
expected_stderr='maximum recursion depth exceeded'
