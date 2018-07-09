#inline $INCLUDES_DIR/return-compile.bats

function input_source {
  cat <<EOF
#include <iostream>
using namespace std;

int main() {
  cout << "hola mundo\n"
  return 0;
}
EOF
}

function expected_output {
  echo null
}

function expected_stderr {
  echo -en "/tmp/main.cpp: In function 'int main()':\n/tmp/main.cpp:6:3: error: expected ';' before 'return'\n   return 0;\n   ^~~~~~\n"
}

EXP_EC=1
