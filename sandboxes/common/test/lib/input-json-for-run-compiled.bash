#inline fun-is-set.bash
#inline var-is-set.bash
#inline var-not-empty.bash

function compiled_program {
  set -e
  fun_is_set sandbox
  var_not_empty COMPILE_IMAGE
  var_not_empty CONTAINER_NAME
  var_is_set source_program
  echo '{}' | \
      jshon -s "$source_program" -i sourceProgram | \
      IMAGE=$COMPILE_IMAGE CONTAINER_NAME=compile-$CONTAINER_NAME sandbox | \
      jshon -e compiledProgram -u
}

function input_json {
  set -e
  : ${stdin:=''}
  echo "{ \"compiledProgram\": \"$(compiled_program)\", \"stdin\":\"$stdin\" }"
}
