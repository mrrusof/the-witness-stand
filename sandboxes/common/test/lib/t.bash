#inline fail.bash

function t_fail {
  if [ $# = 3 ]; then
    case "$2" in
      =|=~)
        fail "$(cat <<EOF
t A $2 B
A:
$1
B:
$3
EOF
)"
      ;;
      *)
        fail "t $@"
      ;;
    esac
  else
    fail "t $@"
  fi
  return 1
}

function t {
  if [[ $@ =~ [=][~] ]]; then
    if [ $# = 3 ]; then
      [[ $1 =~ $3 ]] || t_fail "$@"
    else
      fail t: unhandled use of '=~': $@
    fi
  else
    [ "$@" ] || t_fail "$@"
  fi
}
