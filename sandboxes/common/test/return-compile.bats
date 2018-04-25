#inline params-compile.bash
#inline lib/input-source.bash
#inline return.bats

function expected_stdout {
  echo ''
}

function other_checks {
  [ "`type -t expected_stdout`" = function ]
  value stdout is "`expected_stdout`"
}
