#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

TIMEOUT=5

source_program=$(cat <<"EOF"
public class Main {
    public static void main(String... args) throws InterruptedException {
        Thread.sleep(3600000);
    }
}
EOF
)
