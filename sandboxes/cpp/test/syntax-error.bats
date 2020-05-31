#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
#include <iostream>
using namespace std;

int main() {
  cout << "hola mundo\n"
  return 0;
}
EOF
)

expected_exit_code=1

expected_binary_program=null

expected_stderr=$(cat <<"EOF"
/tmp/main.cpp: In function 'int main()':
/tmp/main.cpp:6:3: error: expected ';' before 'return'
   return 0;
   ^~~~~~
EOF
)


