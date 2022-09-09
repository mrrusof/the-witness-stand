#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
puts require('active_record')
puts require('action_view')
puts require('action_dispatch')
EOF
)

expected_stdout=$(cat <<"EOF"
true
true
true
EOF
)
