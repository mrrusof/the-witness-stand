#inline var-is-set.bash

: ${program_input:=''}

function input_json {
  set -e
  var_is_set interpreted_program
  var_is_set program_input
  echo "{ \"input\":\"$program_input\" }" | jshon -s "$interpreted_program" -i interpretedProgram
}
