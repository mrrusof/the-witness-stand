#inline ../../../../cli/lib/sandbox.sh

function pipe_input_into_sandbox {
  [ "`type -t input_json`" = function ]
  [ "`type -t user_command`" = function ]
  input_json | sandbox
}
