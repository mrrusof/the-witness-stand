#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
print("this is line 1")
print("this is line 2")
EOF
)

expected_stdout=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
