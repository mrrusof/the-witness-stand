#inline lib/consts.bash
#inline lib/pipe-input-json-into-sandbox.bash
#inline lib/checks/sandbox.bash

@test "$TEST_SUITE::$TEST_CASE: We can stop sandbox by SIGTERM." {
  run pipe_input_json_into_sandbox
  [ "$status" = 124 ] # we could stop the sandbox
  [ "$output" = "" ] # there are no lines of output
  sandbox_is_not_running
  sandbox_does_not_exist
}
