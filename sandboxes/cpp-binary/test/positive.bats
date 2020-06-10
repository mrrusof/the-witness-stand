#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <iostream>
using namespace std;

int main() {
  cout << "this is line 1\n";
  cout << "this is line 2\n";
  return 0;
}
EOF
)

expected_stdout=$(cat <<"EOF"
this is line 1
this is line 2
EOF
)
