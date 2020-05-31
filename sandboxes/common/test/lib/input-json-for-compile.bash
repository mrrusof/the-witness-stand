function input_json {
  [ -v source_program ]
  echo '{}' | jshon -s "$source_program" -i source
}
