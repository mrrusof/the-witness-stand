#inline fail.bash
#inline var-is-set.bash

function output_json {
  var_is_set output
  case "$1" in
    pair_count)
      shift
      set -e
      [ $# = 0 ] || fail output_json: expected one parameter: '$#' = $#
      jshon -l <<<"$output"
    ;;
    value)
      set -e
      [ $# = 2 ] || fail output_json: expected two parameters: '$#' = $#
      jshon -e "$2" -u <<<"$output"
    ;;
    *)
      echo output_json: Unknown subcommand $1
      exit 1
    ;;
  esac
}
