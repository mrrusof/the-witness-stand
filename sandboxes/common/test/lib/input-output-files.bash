declare -gA input_files

function input_files_json_object {
  parts_tmp=`mktemp`
  for i in ${!input_files[@]}; do
    printf '%s' "${input_files[$i]}" | jq -R --slurp '{"'$i'": .}' >>$parts_tmp
  done
  jq --slurp '. | add' $parts_tmp
}

function output_files_json_array {
  : ${output_files:=''}
  if [ -z "$output_files" ]; then
   echo '[]'
  else
    echo "[\"$output_files\"]" | sed -e 's/ /", "/g'
  fi
}
