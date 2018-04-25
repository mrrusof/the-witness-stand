function input_json {
  [ "`type -t input_source`" = function ]
  echo '{}' | jshon -s "$(input_source)" -i source
}
