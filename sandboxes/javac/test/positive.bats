#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
public class Main {
  public static void main(String[] a) {
    System.out.println("hola");
  }
}
EOF
)
