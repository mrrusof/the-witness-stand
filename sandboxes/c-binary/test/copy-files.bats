#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

void copy_files(char *infile, char *outfile) {
  FILE *input;
  FILE *output;
  input = fopen(infile, "r");
  output = fopen(outfile, "w");
  char *buffer = NULL;
  size_t size = 0;
  while (getline(&buffer, &size, input) != -1) {
    printf("%s", buffer);
    fprintf(output, "%s", buffer);
  }
  fclose(input);
  fclose(output);
}

int main() {
  copy_files("/tmp/in1", "/tmp/out1");
  copy_files("/tmp/in2", "/tmp/out2");
  return 0;
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
