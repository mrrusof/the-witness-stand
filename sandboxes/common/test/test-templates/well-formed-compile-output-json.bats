#inline ../lib/consts.bash
#inline ../lib/input-json-for-compile.bash
#inline ../lib/pipe-input-json-into-sandbox.bash
#inline ../lib/checks/output-json-shape.bash
#inline ../lib/checks/output-json-values.bash
#inline ../lib/checks/output-json-wall-time-format.bash
#inline ../lib/checks/sandbox.bash

: ${expected_exit_code:=0}
: ${expected_binary_program:=.+}
: ${expected_stdout:=''}
: ${expected_stderr:=''}

@test "$TEST_SUITE::$TEST_CASE: Sandbox returns well-formed compile JSON object." {
  run pipe_input_json_into_sandbox
  output_json_pair_count_is 5
  wall_time_format_is_mins_and_secs
  value exitCode is "$expected_exit_code"
  value binaryProgram like "$expected_binary_program"
  value stdout is "$expected_stdout"
  value stderr is "$expected_stderr"
  sandbox_is_not_running
  sandbox_does_not_exist
}
