#inline $INCLUDES_DIR/test-templates/well-formed-compile-output-json.bats

source_program=$(cat <<"EOF"
#include <pthread.h>
#include <stdio.h>

void *thread_start(void *ptr) {
  fprintf(stderr, "thread\n");
  return ptr;
}

int main(int argc, char **argv) {
  pthread_t thread;
  pthread_create(&thread, NULL, &thread_start, NULL);
  pthread_join(thread, NULL);
  return 0;
}
EOF
)