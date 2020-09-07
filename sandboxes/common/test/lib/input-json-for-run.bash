#inline input-output-fds.bash
#inline input-output-files.bash

function input_json {
  set -e
  parts_tmp=`mktemp`
  program_json_object >$parts_tmp
  if [ -n "${stdin+x}" ]; then
    printf '%s' "$stdin" | jq -R --slurp '{stdin: .}' >>$parts_tmp
  fi
  if [[ "`input_fds_json_object | jq length`" > 0 ]]; then
    input_fds_json_object | jq '{inputFds: .}' >>$parts_tmp
  fi
  if [[ "`output_fds_json_array | jq length`" > 0 ]]; then
    output_fds_json_array | jq '{outputFds: .}' >>$parts_tmp
  fi
  if [[ "`input_files_json_object | jq length`" > 0 ]]; then
    input_files_json_object | jq '{inputFiles: .}' >>$parts_tmp
  fi
  if [[ "`output_files_json_array | jq length`" > 0 ]]; then
    output_files_json_array | jq '{outputFiles: .}' >>$parts_tmp
  fi
  jq --slurp '. | add' $parts_tmp
}
