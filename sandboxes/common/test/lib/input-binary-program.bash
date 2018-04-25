function binary_program {
  [ -v COMPILE_IMAGE ]
  [ -v CONTAINER_NAME ]
  [ "`type -t input_source`" = function ]
  [ "`type -t sandbox`" = function ]
  echo '{}' | \
      jshon -s "$(input_source)" -i source | \
      IMAGE=$COMPILE_IMAGE CONTAINER_NAME=compile-$CONTAINER_NAME sandbox | \
      jshon -e binaryProgram -u
}

function input_json {
  echo "{ \"binaryProgram\": \"$(binary_program)\", \"input\":\"\" }"
}
