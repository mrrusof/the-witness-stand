#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import sys

def copy_fds(in_file, out_file):
  input = open(in_file, 'r')
  output = open(out_file, 'w')
  line = input.read()
  output.write(line)
  print(line)
  input.close()
  output.close()

copy_fds("/tmp/in1", "/tmp/out1")
copy_fds("/tmp/in2", "/tmp/out2")
EOF
)

input_files[/tmp/in1]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in2]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in3]=hola

expected_stdout=$(cat <<EOF
${input_files[/tmp/in1]}
${input_files[/tmp/in2]}
EOF
)

expected_output_files[/tmp/out1]="${input_files[/tmp/in1]}"
expected_output_files[/tmp/out2]="${input_files[/tmp/in2]}"
expected_output_files[/tmp/out3]=null
