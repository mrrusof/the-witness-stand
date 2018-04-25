#inline $INCLUDES_DIR/return-interpreted.bats

function input_source {
  cat <<EOF
puts 'this is line 1'
puts 'this is line 2'
EOF
}

function expected_output {
  echo -e "this is line 1\nthis is line 2\n"
}
