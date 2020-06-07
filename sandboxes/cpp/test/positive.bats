#inline $INCLUDES_DIR/test-templates/compile-positive.bats

source_program=$(cat <<"EOF"
#include <iostream>
using namespace std;

int main() {
  cout << "hola mundo\n";
  return 0;
}
EOF
)
