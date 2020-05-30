#inline ../output.bash

function json_pair_count_is {
  [ "$(out_json | jshon -l)" = "$1" ]
}

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
    echo $1 = "$value"
    echo expected = "$2"
    return 1
  fi
}

function value_like {
  [ -z "$2" ] && return 1
  echo "$(get_value $1)" | grep "$2" >/dev/null 2>&1
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
