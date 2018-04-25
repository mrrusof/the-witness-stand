#inline $INCLUDES_DIR/runtime-error-interpreted.bats

function input_source {
  cat <<EOF
def this_wont_end_well n
  puts 'not a good idea'
  this_wont_end_well(n + 1)
end

this_wont_end_well 0
EOF
}

function expected_output {
  echo 'not a good idea'
}

function expected_stderr {
  echo 'stack level too deep'
}
