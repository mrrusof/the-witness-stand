#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <stdio.h>
#include <stdlib.h>

void copy_fds(int infd, int outfd) {
  FILE *input;
  FILE *output;
  input = fdopen(infd, "r");
  output = fdopen(outfd, "w");
  char *buffer = NULL;
  size_t size = 0;
  while (getline(&buffer, &size, input) != -1) {
    printf("%s", buffer);
    fprintf(output, "%s", buffer);
  }
  free(buffer);
  fclose(input);
  fclose(output);
}

void copy_stdin_stdout() {
  char *buffer = NULL;
  size_t size = 0;
  while (getline(&buffer, &size, stdin) != -1) {
    printf("%s", buffer);
  }
}

int main() {
  copy_stdin_stdout();
  copy_fds(86, 98);
  copy_fds(87, 99);
  return 0;
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
