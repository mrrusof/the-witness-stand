#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
out1 = File.stream!("/tmp/out1")
File.stream!("/tmp/in1") |> Enum.each(&IO.write(:stdio, &1))
File.stream!("/tmp/in1") |> Enum.into(out1)

out2 = File.stream!("/tmp/out2")
File.stream!("/tmp/in2") |> Enum.each(&IO.write(:stdio, &1))
File.stream!("/tmp/in2") |> Enum.into(out2)
EOF
)

input_files[/tmp/in1]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in2]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in3]=hola

expected_stdout="${input_files[/tmp/in1]}${input_files[/tmp/in2]}"

expected_output_files[/tmp/out1]="${input_files[/tmp/in1]}"
expected_output_files[/tmp/out2]="${input_files[/tmp/in2]}"
expected_output_files[/tmp/out3]=null
