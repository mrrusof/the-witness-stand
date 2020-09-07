#inline var-is-set.bash

function input_json {
  set -e
  var_is_set source_program
  jq -n --arg sp "$source_program" '{sourceProgram: $sp}'
}
