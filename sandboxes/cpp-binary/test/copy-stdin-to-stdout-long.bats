#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

int main() {
  char *buffer = NULL;
  size_t size;
  while (getline(&buffer, &size, stdin) != -1) {
    printf("%s", buffer);
  }
  return 0;
}
EOF
)

stdin=$(</dev/urandom tr -dc 'A-Za-z0-9\n' | head -c 125000)

expected_stdout="$stdin"
