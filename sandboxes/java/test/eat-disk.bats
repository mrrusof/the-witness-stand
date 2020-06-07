#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

source_program=$(cat <<"EOF"
public class Main {
    public static void main(String... args) throws Exception {
        Runtime.getRuntime()
               .exec("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576")
               .waitFor();
    }
}
EOF
)
