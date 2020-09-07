#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class Main {
  public static void main(String... args) throws FileNotFoundException, IOException {
    copyStdinStdout();
    copyFiles("/proc/self/fd/86", "/proc/self/fd/98");
    copyFiles("/proc/self/fd/87", "/proc/self/fd/99");
  }

  private static void copyStdinStdout() throws IOException {
    byte bytes[] = new byte[4096];
    int len = 0;
    while ((len = System.in.read(bytes)) > 0) {
      System.out.write(bytes, 0, len);
    }
  }

  private static void copyFiles(String inFile, String outFile) throws FileNotFoundException, IOException {
    FileInputStream inStream = new FileInputStream(inFile);
    FileOutputStream outStream = new FileOutputStream(outFile);
    byte bytes[] = new byte[4096];
    int len = 0;
    while ((len = inStream.read(bytes)) > 0) {
      System.out.write(bytes, 0, len);
      outStream.write(bytes, 0, len);
    }
    inStream.close();
    outStream.close();
  }
}
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[86]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[87]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_fds[88]=hola

expected_stdout="${stdin}${input_fds[86]}${input_fds[87]}"

expected_output_fds[98]="${input_fds[86]}"
expected_output_fds[99]="${input_fds[87]}"
expected_output_fds[100]=null
