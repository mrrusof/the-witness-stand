#inline var-is-set.bash

function input_json {
  set -e
  var_is_set source_program
  printf '%s' "$source_program" | jq -R --slurp '{sourceProgram: .}'
}
