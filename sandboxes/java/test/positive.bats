#inline compile-image.bash
#inline $INCLUDES_DIR/return-binary.bats

function input_source {
  cat <<EOF
public class Main {
    public static void main(String... args) {
        System.out.println("this is line 1");
        System.out.println("this is line 2");
    }
}
EOF
}

function expected_output {
  echo -e "this is line 1\nthis is line 2\n"
}


