#inline ../lib/consts.bash
#inline ../lib/t.bash
#inline ../../../../cli/lib/sandbox.sh

@test "$SANDBOX::$TEST_SUBJECT: Sandbox does not have access to Internet." {
  run sandbox ls /sys/class/net
  t "$output" = lo
}
