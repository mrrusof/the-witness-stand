#inline timeout-preamble.bash

function input_source {
  cat <<EOF
public class Main {
    public static void main(String... args) throws Exception {
        Runtime.getRuntime()
               .exec("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576")
               .waitFor();
    }
}
EOF
}
