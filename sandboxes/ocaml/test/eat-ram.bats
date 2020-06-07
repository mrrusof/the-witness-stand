#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

source_program=$(cat <<"EOF"
let rec inf_loop (i, nn) = inf_loop (i + 1, i :: nn);;
let rec run_threads n tt =
  if n > 0 then
    run_threads (n - 1) ((Thread.create inf_loop (0, [])) :: tt)
  else
    tt
;;
let rec join_threads = function
  | t :: tt -> Thread.join t; join_threads tt
  | [] -> ()
;;
join_threads (run_threads 1000 []);;
(*threads = []
1000.times do
  threads << Thread.new do
    i = 0
    nn = []
    while true
      nn << i += 1
    end
  end
end

threads.each { |t| t.join }*)
EOF
)
