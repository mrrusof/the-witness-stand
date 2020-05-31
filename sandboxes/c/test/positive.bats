#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

int main() {
  printf("hola mundo\n");
  return 0;
}
EOF
)
