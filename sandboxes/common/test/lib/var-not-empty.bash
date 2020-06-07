#inline fail.bash

function var_not_empty {
  declare -n var=$1
  [ -n "$var" ] || fail $1 not given
}
