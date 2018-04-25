#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
defmodule W00t do
  def this_wont_end_well(n, acc) do
    IO.print "not a good idea"
    this_wont_end_well(n + 1, [n|acc]) ++ acc
  end
end

1..1000
|> Enum.each fn _ ->
  spawn fn ->
    IO.puts inspect(W00t.this_wont_end_well(0, []))
  end
end

receive do _ -> nil end
EOF
}
