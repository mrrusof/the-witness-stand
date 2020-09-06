#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
try
  while true do
    output_char stdout (input_char stdin)
  done
with End_of_file -> ()
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 125000)

expected_stdout="$stdin"
