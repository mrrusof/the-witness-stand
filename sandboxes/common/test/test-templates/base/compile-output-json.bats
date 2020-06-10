#inline ../../lib/consts.bash
#inline ../../lib/expected-wall-time-format.bash
#inline ../../lib/fun-is-set.bash
#inline ../../lib/input-json-for-compile.bash
#inline ../../lib/pipe-input-json-into-sandbox.bash
#inline ../../lib/output-json.bash
#inline ../../lib/sandbox-checks.bash
#inline ../../lib/t.bash

@test "$SANDBOX::$TEST_SUBJECT: $TEST_NAME" {
  fun_is_set input_json

  : ${expected_exit_code:=0}
  : ${expected_compiled_program:=.+}
  : ${expected_stdout:=''}
  : ${expected_stderr:=''}

  run pipe_input_json_into_sandbox

  t "$status" = 0
  t "`output_json pair_count`" = 5
  t "`output_json value wallTime`" =~ "$expected_wall_time_format"
  t "`output_json value exitCode`" = "$expected_exit_code"
  t "`output_json value compiledProgram`" =~ "$expected_compiled_program"
  t "`output_json value stdout`" = "$expected_stdout"
  t "`output_json value stderr`" = "$expected_stderr"  
  sandbox_is_not_running
  sandbox_does_not_exist
}
