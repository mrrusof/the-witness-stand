function input_json {
  [ "`type -t input_source`" = function ]
  echo '{ "input":"" }' | jshon -s "$(input_source)" -i interpretedProgram
}
