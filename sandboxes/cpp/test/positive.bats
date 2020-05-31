#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
#include <iostream>
using namespace std;

int main() {
  cout << "hola mundo\n";
  return 0;
}
EOF
)
