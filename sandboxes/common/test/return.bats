#inline lib/consts.bash
#inline lib/pipe-input-json-into-sandbox.bash
#inline lib/checks/sandbox.bash
#inline lib/checks/output-json-shape.bash
#inline lib/checks/output-json-values.bash
#inline lib/checks/output-json-wall-time-format.bash

: ${EXP_EC:=0}

function expected_stdout {
  echo ''
}

function expected_stderr {
  echo ''
}

@test "$TEST_SUITE::$TEST_CASE: Sandbox returns expected JSON object." {
  [ "`type -t expected_output`" = function ]
  [ "`type -t expected_stderr`" = function ]
  run pipe_input_json_into_sandbox
  output_json_pair_count_is $JSON_PAIR_COUNT
  value exitCode is $EXP_EC
  wall_time_format_is_mins_and_secs
  value $ACTUAL_OUTPUT_FIELD is "`expected_output`"
  value stderr is "`expected_stderr`"
  [ -v other_checks ] && other_checks
  sandbox_is_not_running
  sandbox_does_not_exist
}
