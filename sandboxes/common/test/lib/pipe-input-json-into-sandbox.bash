#inline ../../../../cli/lib/sandbox.sh
#inline fun-is-set.bash

function pipe_input_json_into_sandbox {
  set -e
  set -o pipefail
  fun_is_set input_json
  input_json | sandbox
}
