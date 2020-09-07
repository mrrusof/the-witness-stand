#inline input-json-for-run.bash
#inline var-is-set.bash

function program_json_object {
  set -e
  var_is_set interpreted_program
  printf '%s' "$interpreted_program" | jq -R --slurp '{interpretedProgram: .}'
}
