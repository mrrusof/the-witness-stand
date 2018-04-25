#inline lib/context-vars.bash

TIMEOUT=3

@test "$TEST_SUITE::$TEST_CASE: Sandbox does not have access to Internet." {
  nslookup google.com
  ! user_command nslookup google.com <&-
}
