#inline fun-is-set.bash
#inline var-is-set.bash
#inline var-not-empty.bash

function compiled_program_json {
  set -e
  fun_is_set sandbox
  var_not_empty COMPILE_IMAGE
  var_not_empty CONTAINER_NAME
  var_is_set source_program
  jq -n --arg sp "$source_program" '{sourceProgram: $sp}' | \
    IMAGE=$COMPILE_IMAGE CONTAINER_NAME=compile-$CONTAINER_NAME sandbox | \
    jq '{"compiledProgram"}'
}

function input_json {
  set -e
  : ${stdin:=''}
  compiled_program_json | jq --arg stdin "$stdin" '. "stdin" = $stdin'
}
