#inline fail.bash

function fun_is_set {
  declare -n var=$1
  [ "`type -t $1`" = function ] || fail $1 not set
}
