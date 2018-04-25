#inline timeout-preamble.bash

function input_source {
  cat <<EOF
public class Main {
    public static void main(String... args) throws InterruptedException {
        Thread.sleep(3600000);
    }
}
EOF
}
