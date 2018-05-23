load ../helper

function input_json {
  cat <<EOF
{ "interpretedProgram": "puts 'hola'", "input": "" }
EOF
}

function expected_usage_sandbox_container_params {
  input_json | the-witness-stand ruby my-ruby
}

function expected_usage_sandbox_param {
  input_json | the-witness-stand ruby
}

function three_parameters {
  input_json | the-witness-stand ruby my-ruby garbage
}

function no_parameter {
  input_json | the-witness-stand
}

function matches {
  if ! echo "$1" | grep "$2"; then
    echo failed: matches "$1" "$2"
    false
  fi
}

function has_usage {
  if ! matches "$1" 'Usage'; then
    echo failed: has_usage "$1"
  fi
}

function available_sandboxes {
  grep PROCESS $SANDBOXES_DIR/*/Makefile | sed 's/.*PROCESS=//' | sort
}

function download_commands {
  for s in `available_sandboxes`; do
    echo docker pull ${DOCKER_IMAGE_PREFIX}$s-sandbox${DOCKER_IMAGE_SUFFIX}
  done
}

function docker {
  if [ "$1" = pull ]; then
    echo docker pull $2
  else
    echo unknown action for \"docker "$1" "$2"\"
  fi
}

@test "$TEST_SUITE: accepts a sandbox name and a container name." {
  run expected_usage_sandbox_container_params
  actual_output=`echo $output | jshon -e actualOutput`
  echo \$output = $output
  [ $status = 0 ]
  [ "$actual_output" = '"hola\n"' ]
}

@test "$TEST_SUITE: accepts a sandbox name." {
  run expected_usage_sandbox_param
  actual_output=`echo $output | jshon -e actualOutput`
  echo \$output = $output
  [ $status = 0 ]
  [ "$actual_output" = '"hola\n"' ]
}

@test "$TEST_SUITE: does not work with less than one parameter or more than two." {
  msg='Wrong number of parameters.'
  run three_parameters
  [ $status = 1 ]
  matches "$output" "$msg"
  has_usage "$output"
  run no_parameter
  [ $status = 1 ]
  matches "$output" "$msg"
  has_usage "$output"
}

@test "$TEST_SUITE: downloads sandboxes with option {-d,--download}." {
  export -f docker
  run the-witness-stand -d
  [ $status = 0 ]
  [ "$output" = "`download_commands`" ]
  run the-witness-stand --download
  [ $status = 0 ]
  [ "$output" = "`download_commands`" ]
}

@test "$TEST_SUITE: shows available sandboxes with option {-l,--list}." {
  run the-witness-stand -l
  [ $status = 0 ]
  [ "$output" = "`available_sandboxes`" ]
  run the-witness-stand --list
  [ $status = 0 ]
  [ "$output" = "`available_sandboxes`" ]
}

@test "$TEST_SUITE: shows version with option {-v,--version}." {
  run the-witness-stand -v
  [ $status = 0 ]
  [ "$output" = "$VERSION" ]
  run the-witness-stand --version
  [ $status = 0 ]
  [ "$output" = "$VERSION" ]
}

@test "$TEST_SUITE: shows help with option {-h,--help}." {
  run the-witness-stand -h
  [ $status = 0 ]
  has_usage "$output"
  run the-witness-stand --help
  [ $status = 0 ]
  has_usage "$output"
}

@test "$TEST_SUITE: fails with unknown option." {
  msg='Unknown option -w.'
  run the-witness-stand -w
  [ $status = 2 ]
  matches "$output" "$msg"
  has_usage "$output"
  run the-witness-stand -w ruby
  [ $status = 2 ]
  matches "$output" "$msg"
  has_usage "$output"
  run the-witness-stand -w ruby my-ruby
  [ $status = 2 ]
  matches "$output" "$msg"
  has_usage "$output"
}
