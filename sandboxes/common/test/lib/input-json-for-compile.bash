#inline var-is-set.bash

function input_json {
  set -e
  var_is_set source_program
  echo '{}' | jshon -s "$source_program" -i sourceProgram
}
