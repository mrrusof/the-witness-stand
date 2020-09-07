#inline ../../lib/consts.bash
#inline ../../lib/expected-wall-time-format.bash
#inline ../../lib/fun-is-set.bash
#inline ../../lib/output-json.bash
#inline ../../lib/pipe-input-json-into-sandbox.bash
#inline ../../lib/sandbox-checks.bash
#inline ../../lib/t.bash

declare -ga expected_output_fds
declare -gA expected_output_files

@test "$SANDBOX::$TEST_SUBJECT: $TEST_NAME" {
  fun_is_set input_json

  : ${op_stdout:='='}
  : ${op_stderr:='='}

  : ${expected_exit_code:=0}
  if [ -z "${expected_stdout+x}" ]; then expected_stdout=null; fi
  if [ -z "${expected_stderr+x}" ]; then expected_stderr=null; fi

  output_fds="${!expected_output_fds[@]}"
  output_files="${!expected_output_files[@]}"

  run pipe_input_json_into_sandbox

  t "$status" = 0
  t "`output_json length`" = 6
  t "`output_json .wallTime`" =~ "$expected_wall_time_format"
  t "`output_json .exitCode`" = "$expected_exit_code"
  t "`output_json .stdout`" $op_stdout "$expected_stdout"
  t "`output_json .stderr`" $op_stderr "$expected_stderr"
  for i in ${!expected_output_fds[@]}; do
    t "`output_json .outputFds.'"'$i'"'`" = "${expected_output_fds[$i]}"
  done
  for i in ${!expected_output_files[@]}; do
    t "`output_json .outputFiles.'"'$i'"'`" = "${expected_output_files[$i]}"
  done
  sandbox_is_not_running
  sandbox_does_not_exist
}
