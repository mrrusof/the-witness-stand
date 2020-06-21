#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
class Solution {
    public void printOk() {
        System.out.println("ok!");
    }
}

public class Main {
    public static void main(String... args) {
        Solution s = new Solution();
        s.printOk();
    }
}
EOF
)

expected_stdout=$(cat <<"EOF"
ok!
EOF
)
