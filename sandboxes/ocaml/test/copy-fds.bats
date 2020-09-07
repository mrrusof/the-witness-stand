#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
let stdout_fd = Unix.descr_of_out_channel stdout in
let copy_stdin_to_stdout () =
  try
    while true do
      let _ = Unix.write stdout_fd (Bytes.make 1 (input_char stdin)) 0 1 in ()
    done
  with End_of_file -> ()
in
let copy_files infile outfile =
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
in
let in1 =  "/proc/self/fd/86" in
let in2 =  "/proc/self/fd/87" in
let out1 = "/proc/self/fd/98" in
let out2 = "/proc/self/fd/99" in
copy_stdin_to_stdout ();
copy_files in1 out1;
copy_files in2 out2
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[86]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[87]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[88]=hola

expected_stdout="${stdin}${input_fds[86]}${input_fds[87]}"

expected_output_fds[98]="${input_fds[86]}"
expected_output_fds[99]="${input_fds[87]}"
expected_output_fds[100]=null
