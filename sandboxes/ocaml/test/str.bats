#inline $INCLUDES_DIR/return-interpreted.bats

function input_source {
  cat <<EOF
let s = "hola mundo" in
let l = Str.split (Str.regexp " ") s in
List.iter (fun e -> Printf.printf "%s\n" e) l
EOF
}

function expected_output {
  echo -e "hola\nmundo\n"
}


