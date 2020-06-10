#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
Printf.printf "this is line 1\n";;
Printf.printf "this is line 2\n";;
EOF
)

expected_stdout=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
