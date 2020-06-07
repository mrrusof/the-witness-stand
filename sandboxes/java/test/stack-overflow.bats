#inline $INCLUDES_DIR/test-templates/run-compiled-runtime-error.bats

source_program=$(cat <<"EOF"
public class Main {

    public static void main(String... args) throws InterruptedException {
        thisWontEndWell(0);
    }

    static void thisWontEndWell(int n) {
        thisWontEndWell(n + 1);
    }

}
EOF
)

op_stderr='=~'
expected_stderr='Exception in thread "main" java.lang.StackOverflowError.*'
