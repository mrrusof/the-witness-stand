#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

source_program=$(cat <<"EOF"
int main() {
  system("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576");
}
EOF
)
