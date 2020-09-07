#inline fail.bash
#inline var-is-set.bash

function output_json {
  var_is_set output
  jq -r "$@" <<<"$output"
}
