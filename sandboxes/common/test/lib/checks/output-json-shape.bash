#inline ../output.bash

function output_json_pair_count_is {
  [ "$(out_json | jshon -l)" = "$1" ]
}
