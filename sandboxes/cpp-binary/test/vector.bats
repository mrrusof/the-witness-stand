#inline $INCLUDES_DIR/test-templates/run-compiled-positive.bats

source_program=$(cat <<"EOF"
#include <vector>
#include <stdio.h>

using namespace std;

int main() {
  vector<int> nn;

  for(int i = 0; i < 10; i++) {
    nn.push_back(i);
  }
  printf("vector size is %d\n", nn.size());
  return 0;
}
EOF
)

expected_stdout=$(cat <<"EOF"
vector size is 10
EOF
)
