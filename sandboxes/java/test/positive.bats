#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
public class Main {
    public static void main(String... args) {
        System.out.println("this is line 1");
        System.out.println("this is line 2");
    }
}
EOF
)

expected_program_output=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
