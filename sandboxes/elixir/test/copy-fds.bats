#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
IO.binstream(:stdio, :line) |> Enum.each(&IO.write(:stdio, &1))

out98 = File.stream!("/proc/self/fd/98")
File.stream!("/proc/self/fd/86") |> Enum.map(fn e -> IO.write(:stdio, e); e end)
                                 |> Enum.into(out98)

out99 = File.stream!("/proc/self/fd/99")
File.stream!("/proc/self/fd/87") |> Enum.map(fn e -> IO.write(:stdio, e); e end)
                                 |> Enum.into(out99)
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
