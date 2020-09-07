#inline $INCLUDES_DIR/test-templates/compile-error.bats

source_program=$(cat <<"EOF"
#include <iostream>
using namespace std;

int main() {
  cout << "hola mundo\n"
  return 0;
}
EOF
)

expected_stderr=$(cat <<"EOF"
/tmp/main.cpp: In function 'int main()':
/tmp/main.cpp:5:25: error: expected ';' before 'return'
    5 |   cout << "hola mundo\n"
      |                         ^
      |                         ;
    6 |   return 0;
      |   ~~~~~~                 
EOF
)
