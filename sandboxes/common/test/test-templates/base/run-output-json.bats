#inline ../../lib/consts.bash
#inline ../../lib/expected-wall-time-format.bash
#inline ../../lib/fun-is-set.bash
#inline ../../lib/output-json.bash
#inline ../../lib/pipe-input-json-into-sandbox.bash
#inline ../../lib/sandbox-checks.bash
#inline ../../lib/t.bash

@test "$SANDBOX::$TEST_SUBJECT: $TEST_NAME" {
  fun_is_set input_json

  : ${op_program_output:='='}
  : ${op_stdout:='='}
  : ${op_stderr:='='}

  : ${expected_exit_code:=0}
  : ${expected_program_output:=''}
  : ${expected_stdout:=''}
  : ${expected_stderr:=''}

  run pipe_input_json_into_sandbox

  t "$status" = 0
  t "`output_json pair_count`" = 4
  t "`output_json value wallTime`" =~ "$expected_wall_time_format";
  t "`output_json value exitCode`" = "$expected_exit_code"
  t "`output_json value programOutput`" $op_program_output "$expected_program_output"
  t "`output_json value stdout`" $op_stdout "$expected_stdout"
  t "`output_json value stderr`" $op_stderr "$expected_stderr"  
  sandbox_is_not_running
  sandbox_does_not_exist
}
