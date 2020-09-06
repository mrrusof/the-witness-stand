#inline var-is-set.bash

function input_json {
  set -e
  var_is_set interpreted_program
  : ${stdin:=''}
  echo '{}' | \
    jshon -s "$stdin" -i stdin | \
    jshon -s "$interpreted_program" -i interpretedProgram
}
