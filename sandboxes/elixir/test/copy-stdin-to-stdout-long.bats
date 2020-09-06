#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
IO.binstream(:stdio, :line) |> Enum.each(&IO.write(:stdio, &1))
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 125000)

expected_stdout="$stdin"
