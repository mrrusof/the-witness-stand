#inline $INCLUDES_DIR/test-templates/run-interpreted-runtime-error.bats

interpreted_program=$(cat <<"EOF"
def this_wont_end_well(n):
  print("not a good idea")
  this_wont_end_well(n + 1)

this_wont_end_well(0)
EOF
)

op_stdout='=~'
expected_stdout='not a good idea'

op_stderr='=~'
expected_stderr='maximum recursion depth exceeded'
