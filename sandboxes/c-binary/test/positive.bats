#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <stdio.h>

int main() {
  printf("this is line 1\n");
  printf("this is line 2\n");
  return 0;
}
EOF
)

expected_stdout=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
