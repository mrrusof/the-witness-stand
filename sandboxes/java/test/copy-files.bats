#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class Main {
  public static void main(String... args) throws FileNotFoundException, IOException {
    copyFiles("/tmp/in1", "/tmp/out1");
    copyFiles("/tmp/in2", "/tmp/out2");
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

input_files[/tmp/in1]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in2]=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 250000)
input_files[/tmp/in3]=hola

expected_stdout="${input_files[/tmp/in1]}${input_files[/tmp/in2]}"

expected_output_files[/tmp/out1]="${input_files[/tmp/in1]}"
expected_output_files[/tmp/out2]="${input_files[/tmp/in2]}"
expected_output_files[/tmp/out3]=null
