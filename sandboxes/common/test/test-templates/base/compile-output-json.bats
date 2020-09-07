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
  if [ -z "${expected_stdout+x}" ]; then expected_stdout=null; fi
  if [ -z "${expected_stderr+x}" ]; then expected_stderr=null; fi

  run pipe_input_json_into_sandbox

  t "$status" = 0
  t "`output_json length`" = 7
  t "`output_json .wallTime`" =~ "$expected_wall_time_format"
  t "`output_json .exitCode`" = "$expected_exit_code"
  t "`output_json .compiledProgram`" =~ "$expected_compiled_program"
  t "`output_json .stdout`" = "$expected_stdout"
  t "`output_json .stderr`" = "$expected_stderr"
  t "`output_json .outputFds`" = '{}'
  t "`output_json .outputFiles`" = '{}'
  sandbox_is_not_running
  sandbox_does_not_exist
}
