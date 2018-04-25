#inline $INCLUDES_DIR/timeout-interpreted.bats

function input_source {
  cat <<EOF
let rec inf_loop i = inf_loop (i + 1);;
let rec run_threads n tt =
  if n > 0 then
    run_threads (n - 1) ((Thread.create inf_loop 0) :: tt)
  else
    tt
;;
let rec join_threads = function
  | t :: tt -> Thread.join t; join_threads tt
  | [] -> ()
;;
join_threads (run_threads 1000 []);;
EOF
}
