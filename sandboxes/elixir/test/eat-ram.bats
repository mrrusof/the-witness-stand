#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

source_program=$(cat <<"EOF"
1..1000
|> Enum.map(fn _ ->
  spawn fn ->
    Enum.reduce(Stream.cycle([[1]]), [], fn a, e -> a ++ e end)
  end
end)

receive do _ -> nil end
EOF
)
