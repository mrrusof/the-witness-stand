declare -ga input_fds

function input_fds_json_object {
  parts_tmp=`mktemp`
  for i in ${!input_fds[@]}; do
    printf '%s' "${input_fds[i]}" | jq -R --slurp '{"'$i'": .}' >>$parts_tmp
  done
  jq --slurp '. | add' $parts_tmp
}

function output_fds_json_array {
  : ${output_fds:=''}
  echo "[$output_fds]" | sed 's/ /, /g'
}
