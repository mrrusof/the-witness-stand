#inline ../lib/input-json-for-compile.bash
#inline base/compile-output-json.bats

TEST_NAME='Sandbox returns expected compile error.'

: ${expected_exit_code:=1}
: ${expected_binary_program:=null}
