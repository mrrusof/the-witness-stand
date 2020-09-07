#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
import sys

def copy_fds(infd, outfd):
  input = open(infd, 'r')
  output = open(outfd, 'w')
  line = input.read()
  output.write(line)
  print(line)
  input.close()
  output.close()

print(sys.stdin.read())
copy_fds(86, 98)
copy_fds(87, 99)
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[86]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[87]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[88]=hola

expected_stdout=$(cat <<EOF
${stdin}
${input_fds[86]}
${input_fds[87]}
EOF
)

expected_output_fds[98]="${input_fds[86]}"
expected_output_fds[99]="${input_fds[87]}"
expected_output_fds[100]=null
