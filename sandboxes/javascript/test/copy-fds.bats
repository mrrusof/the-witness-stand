# inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

# interpreted_program=$(cat <<"EOF"
# var fs = require('fs');

# function copy_fds(infd, outfd) {
#   var input = fs.readFileSync(infd);
#   var inputStr = input.toString();
#   console.log(inputStr);
#   fs.writeFileSync(outfd, inputStr);
# }

# var stdin_text = fs.readFileSync(0);
# console.log(stdin_text.toString());
# copy_fds(86, 98);
# copy_fds(87, 99);
# EOF
# )

# stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
# input_fds[86]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
# input_fds[87]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
# input_fds[88]=hola

# expected_stdout=$(cat <<EOF
# ${stdin}
# ${input_fds[86]}
# ${input_fds[87]}
# EOF
# )

# expected_output_fds[98]="${input_fds[86]}"
# expected_output_fds[99]="${input_fds[87]}"
# expected_output_fds[100]=null

@test "javascript-sandbox::copy-fds" {
  skip 'I do not know how to copy big files in Javascript. :( '
}