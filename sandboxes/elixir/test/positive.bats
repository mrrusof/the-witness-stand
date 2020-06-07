#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

source_program=$(cat <<"EOF"
IO.puts "this is line 1"
IO.puts "this is line 2"
EOF
)

expected_program_output=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
