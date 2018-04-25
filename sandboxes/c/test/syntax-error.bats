#inline $INCLUDES_DIR/return-compile.bats

function input_source {
  cat <<EOF
#include <stdio.h>

int main() {
  printf("hola mundo\n")
  return 0;
}
EOF
}

function expected_output {
  echo null
}

function expected_stderr {
  echo -en "/tmp/main.c: In function 'main':\n/tmp/main.c:5:3: error: expected ';' before 'return'\n   return 0;\n   ^~~~~~\n"
}

EXP_EC=1
