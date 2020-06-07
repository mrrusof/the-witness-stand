#inline $INCLUDES_DIR/test-templates/compile-error.bats

source_program=$(cat <<"EOF"
public class Main {
  public static void main(String[] a) {
    System.out.println("hola")
  }
}
EOF
)

expected_stderr=$(cat <<"EOF"
/tmp/Main.java:3: error: ';' expected
    System.out.println("hola")
                              ^
1 error
EOF
)
