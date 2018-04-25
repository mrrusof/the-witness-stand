#inline compile-image.bash
#inline $INCLUDES_DIR/runtime-error-binary.bats

function input_source {
  cat <<EOF
public class Main {

    public static void main(String... args) throws InterruptedException {
        thisWontEndWell(0);
    }

    static void thisWontEndWell(int n) {
        thisWontEndWell(n + 1);
    }

}
EOF
}

function expected_stderr {
  echo 'Exception in thread "main" java.lang.StackOverflowError.*'
}
