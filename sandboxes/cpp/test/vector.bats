#inline $INCLUDES_DIR/test-templates/compile-positive.bats

source_program=$(cat <<"EOF"
#include <vector>

using namespace std;

int main() {
  vector<int> nn;
  for(int i = 0; i < 10; i++) {
    nn.push_back(i);
  }
  return 0;
}
EOF
)
