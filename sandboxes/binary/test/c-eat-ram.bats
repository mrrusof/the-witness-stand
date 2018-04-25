#inline c-timeout-preamble.bash

function input_source {
  cat <<EOF
#include <pthread.h>
#include <stdlib.h>
#include <sys/queue.h>

struct lentry {
  int value;
  SLIST_ENTRY(lentry) next;
} lentry;

void *thread_start(void *param) {
  int j = 0;
  struct lentry *el;
  SLIST_HEAD(lhead, lentry) head = SLIST_HEAD_INITIALIZER(head);
  SLIST_INIT(&head);
  while(1) {
    el = malloc(sizeof(struct lentry));
    el->value = j;
    SLIST_INSERT_HEAD(&head, el, next);
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
}

