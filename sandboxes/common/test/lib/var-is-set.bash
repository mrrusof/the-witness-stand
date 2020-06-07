#inline fail.bash

function var_is_set {
  [ -v "$1" ] || fail $1 not set
}
