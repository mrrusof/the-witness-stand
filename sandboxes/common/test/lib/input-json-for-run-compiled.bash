#inline fun-is-set.bash
#inline var-is-set.bash
#inline var-not-empty.bash

function binary_program {
  set -e
  fun_is_set sandbox
  var_not_empty COMPILE_IMAGE
  var_not_empty CONTAINER_NAME
  var_is_set source_program
  echo '{}' | \
      jshon -s "$source_program" -i sourceProgram | \
      IMAGE=$COMPILE_IMAGE CONTAINER_NAME=compile-$CONTAINER_NAME sandbox | \
      jshon -e binaryProgram -u
}

: ${program_input:=''}

function input_json {
  set -e
  var_is_set program_input
  echo "{ \"binaryProgram\": \"$(binary_program)\", \"input\":\"$program_input\" }"
}
