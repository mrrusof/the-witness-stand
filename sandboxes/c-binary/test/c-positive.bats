#inline c-compile-image.bash
#inline $INCLUDES_DIR/return-binary.bats

function input_source {
  cat <<EOF
#include <stdio.h>

int main() {
  printf("this is line 1\n");
  printf("this is line 2\n");
  return 0;
}
EOF
}

function expected_output {
  echo -e "this is line 1\nthis is line 2\n"
}

