#inline fun-is-set.bash
#inline input-json-for-run.bash
#inline var-is-set.bash
#inline var-not-empty.bash

function compile_output_json {
  set -e
  fun_is_set sandbox
  var_not_empty COMPILE_IMAGE
  var_not_empty CONTAINER_NAME
  var_is_set source_program
  jq -n --arg sp "$source_program" '{sourceProgram: $sp}' | \
    IMAGE=$COMPILE_IMAGE CONTAINER_NAME=compile-$CONTAINER_NAME sandbox
}

function program_json_object {
  compile_output_json | jq '{"compiledProgram"}'
}
