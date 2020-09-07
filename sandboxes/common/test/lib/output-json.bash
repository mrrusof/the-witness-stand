#inline fail.bash
#inline var-is-set.bash

function output_json {
  var_is_set output
  case "$1" in
    pair_count)
      shift
      set -e
      [ $# = 0 ] || fail output_json: expected one parameter: '$#' = $#
      jq length <<<"$output"
    ;;
    value)
      set -e
      [ $# = 2 ] || fail output_json: expected two parameters: '$#' = $#
      jq -r '. "'"$2"'"' <<<"$output"
    ;;
    *)
      echo output_json: Unknown subcommand $1
      exit 1
    ;;
  esac
}
