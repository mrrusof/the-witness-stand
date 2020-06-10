#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
let s = "hola mundo" in
let l = Str.split (Str.regexp " ") s in
List.iter (fun e -> Printf.printf "%s\n" e) l
EOF
)

expected_stdout=$(cat <<"EOF"
hola
mundo
EOF
)
