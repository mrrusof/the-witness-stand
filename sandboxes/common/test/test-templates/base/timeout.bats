#inline ../../lib/consts.bash
#inline ../../lib/fun-is-set.bash
#inline ../../lib/pipe-input-json-into-sandbox.bash
#inline ../../lib/sandbox-checks.bash
#inline ../../lib/t.bash

@test "$SANDBOX::$TEST_SUBJECT: Sandbox stops by SIGTERM." {
  fun_is_set input_json

  run pipe_input_json_into_sandbox

  t "$status" = 124 # We could stop the sandbox by SIGTERM.
  t -z "$output"
  sandbox_is_not_running
  sandbox_does_not_exist
}
