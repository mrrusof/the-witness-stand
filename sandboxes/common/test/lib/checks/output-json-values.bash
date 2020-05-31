#inline ../output.bash

function get_value {
  out_json | jshon -e $1 -u
}

function value_is {
  [ $# = 2 ] || return 1
  value="$(get_value $1)"
  if [ "$value" = "$2" ]; then
    return 0
  else
    echo value $1 is '<expected>':
    echo $1:
    echo "$value"
    echo expected:
    echo "$2"
    return 1
  fi
}

# Uses extended regular expressions, see `man bash`.
function value_like {
  [ -z "$2" ] && return 1
  value="$(get_value $1)"
  if [[ $value =~ $2 ]]; then
    return 0
  else
    echo value $1 like '<regex>':
    echo $1:
    echo "$value"
    echo regex:
    echo "$2"
    return 1
  fi
}

function value {
  case "$2" in
    is)
      value_is "$1" "$3"
    ;;
    like)
      value_like "$1" "$3"
    ;;
  esac
}
