#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
while true
  line = readline rescue break
  puts line
end
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 125000)

expected_stdout="$stdin"
