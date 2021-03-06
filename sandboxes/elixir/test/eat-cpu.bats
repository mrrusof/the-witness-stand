#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
1..10000
|> Enum.map(fn _ ->
  spawn fn ->
    Enum.reduce(Stream.cycle([1]), fn a, e -> a + e end)
  end
end)

receive do _ -> nil end
EOF
)
