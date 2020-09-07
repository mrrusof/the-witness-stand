#inline var-is-set.bash

function input_json {
  set -e
  var_is_set interpreted_program
  : ${stdin:=''}
  jq -n \
    --arg stdin "$stdin" \
    --arg ip "$interpreted_program" \
    '{stdin: $stdin, interpretedProgram: $ip}'
}
