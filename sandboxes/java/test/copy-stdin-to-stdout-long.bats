#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
import java.util.Scanner;

public class Main {
  public static void main(String... args) {
    Scanner scanner = new Scanner(System.in);
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      System.out.println(line);
    }
  }
}
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 125000)

expected_stdout="$stdin"
