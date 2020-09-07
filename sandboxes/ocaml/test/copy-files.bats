#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
let copy_files infile outfile =
  let stdout_fd = Unix.descr_of_out_channel stdout in
  let ifd = Unix.openfile infile [Unix.O_RDONLY] 0o644 in
  let ofd = Unix.openfile outfile [Unix.O_WRONLY; Unix.O_CREAT] 0o644 in
  let buff = Bytes.create 4096 in
  let len = ref (Unix.read ifd buff 0 4096) in
  while !len > 0 do
    let _ = Unix.write ofd buff 0 !len in
    let _ = Unix.write stdout_fd buff 0 !len in
    len := Unix.read ifd buff 0 4096
  done;
  Unix.close ifd;
  Unix.close ofd;
;;
copy_files "/tmp/in1" "/tmp/out1";;
copy_files "/tmp/in2" "/tmp/out2"
EOF
)

input_files[/tmp/in1]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in2]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in3]=hola

expected_stdout="${input_files[/tmp/in1]}${input_files[/tmp/in2]}"

expected_output_files[/tmp/out1]="${input_files[/tmp/in1]}"
expected_output_files[/tmp/out2]="${input_files[/tmp/in2]}"
expected_output_files[/tmp/out3]=null
