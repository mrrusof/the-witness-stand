#inline $INCLUDES_DIR/test-templates/compile-positive.bats

source_program=$(cat <<"EOF"
public class Main {
  public static void main(String[] a) {
    System.out.println("hola");
  }
}
EOF
)
