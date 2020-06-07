#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

source_program=$(cat <<"EOF"
#include <pthread.h>
#include <stdlib.h>

void *thread_start(void *param) {
  int j = 0;
  while(1) {
    j++;
  }
}

int main() {
  int thread_count = 10000;
  int i;
  pthread_t *tt = malloc(thread_count * sizeof(pthread_t));
  for(i = 0; i < thread_count; i++) {
    pthread_create(&tt[i], NULL, &thread_start, NULL);
  }
  for(i = 0; i < thread_count; i++) {
    pthread_join(tt[i], NULL);
  }
}
EOF
)
