#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

int main() {
  printf("hola mundo\n")
  return 0;
}
EOF
)

expected_exit_code=1

expected_binary_program=null

expected_stderr=$(cat <<"EOF"
/tmp/main.c: In function 'main':
/tmp/main.c:5:3: error: expected ';' before 'return'
   return 0;
   ^~~~~~
EOF
)