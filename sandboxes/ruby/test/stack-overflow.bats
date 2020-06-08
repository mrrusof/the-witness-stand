#inline $INCLUDES_DIR/test-templates/run-interpreted-runtime-error.bats

interpreted_program=$(cat <<"EOF"
def this_wont_end_well n
  puts 'not a good idea'
  this_wont_end_well(n + 1)
end

this_wont_end_well 0
EOF
)

op_program_output='=~'
expected_program_output='not a good idea'

op_stderr='=~'
expected_stderr='stack level too deep'

