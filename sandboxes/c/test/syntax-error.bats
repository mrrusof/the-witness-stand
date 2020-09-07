#inline $INCLUDES_DIR/test-templates/compile-error.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

int main() {
  printf("hola mundo\n")
  return 0;
}
EOF
)

expected_stderr=$(cat <<"EOF"
/tmp/main.c: In function 'main':
/tmp/main.c:4:25: error: expected ';' before 'return'
    4 |   printf("hola mundo\n")
      |                         ^
      |                         ;
    5 |   return 0;
      |   ~~~~~~                 
EOF
)
