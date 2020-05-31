#inline ../../../../cli/lib/sandbox.sh

function pipe_input_json_into_sandbox {
  [ "`type -t input_json`" = function ]
  input_json | sandbox
}
