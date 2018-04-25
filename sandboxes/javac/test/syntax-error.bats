#inline $INCLUDES_DIR/return-compile.bats

function input_source {
  cat <<EOF
public class Main {
  public static void main(String[] a) {
    System.out.println("hola")
  }
}
EOF
}

function expected_output {
  echo null
}

function expected_stderr {
  echo -en "/tmp/Main.java:3: error: ';' expected\n    System.out.println(\"hola\")\n                              ^\n1 error\n"
}

EXP_EC=1
