#inline $INCLUDES_DIR/lib/input-source.bash

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

function expected_output {
  echo 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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//////////AAAAAAAAAAD//////////wAAAAAAAAAA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CAAAAAAAAAAYAAAAAAAAAEcAAAAEAAAAQgAAAAAAAAB4BQAAAAAAAHgFAAAAAAAAYAAAAAAAAAADAAAAEgAAAAgAAAAAAAAAGAAAAAAAAABRAAAAAQAAAAYAAAAAAAAA2AUAAAAAAADYBQAAAAAAAA0AAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAATAAAAAEAAAAGAAAAAAAAAPAFAAAAAAAA8AUAAAAAAABQAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAFcAAAABAAAABgAAAAAAAABABgAAAAAAAEAGAAAAAAAAGAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAACAAAAAAAAABgAAAAAQAAAAYAAAAAAAAAWAYAAAAAAABYBgAAAAAAAJ0CAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAZgAAAAEAAAAGAAAAAAAAAPUIAAAAAAAA9QgAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAGwAAAABAAAAAgAAAAAAAAAACQAAAAAAAAAJAAAAAAAALAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAB6AAAAAQAAAAIAAAAAAAAAMAkAAAAAAAAwCQAAAAAAAJgAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAhAAAAAEAAAADAAAAAAAAAPANIAAAAAAA8A0AAAAAAAAQAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAIsAAAABAAAAAwAAAAAAAAAADiAAAAAAAAAOAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAACSAAAAAQAAAAMAAAAAAAAAEA4gAAAAAAAQDgAAAAAAAAgAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAlwAAAAYAAAADAAAAAAAAABgOIAAAAAAAGA4AAAAAAACAAQAAAAAAAAQAAAAAAAAACAAAAAAAAAAQAAAAAAAAAFsAAAABAAAAAwAAAAAAAACYDyAAAAAAAJgPAAAAAAAAaAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAACAAAAAAAAACgAAAAAQAAAAMAAAAAAAAAABAgAAAAAAAAEAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAApgAAAAgAAAADAAAAAAAAACAQIAAAAAAACBAAAAAAAABgAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAKsAAAABAAAAMAAAAAAAAAAAAAAAAAAAAAgQAAAAAAAAGgAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAC0AAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAwEAAAAAAAALAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAwwAAAAEAAAAAAAAAAAAAAAAAAAAAAAAA4BAAAAAAAACLAQAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAM8AAAABAAAAAAAAAAAAAAAAAAAAAAAAAGsSAAAAAAAAtwAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAADdAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAiEwAAAAAAAO0AAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA6QAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAEBQAAAAAAAA4AAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAPYAAAABAAAAMAAAAAAAAAAAAAAAAAAAAEgUAAAAAAAAcQEAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAQAAAQAAAAAAAAAAAAAAAAAAAAAAAAC5FQAAAAAAANYAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAADAEAAAEAAAAAAAAAAAAAAAAAAAAAAAAAkBYAAAAAAACgAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAAAAAAAAAAAAAAAAADAXAAAAAAAAIAcAAAAAAAAfAAAANQAAAAgAAAAAAAAAGAAAAAAAAAAJAAAAAwAAAAAAAAAAAAAAAAAAAAAAAABQHgAAAAAAAEkCAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAEQAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAmSAAAAAAAAAaAQAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==
}

function expected_stdout {
  echo ''
}

function expected_stderr {
  echo ''
}

#inline $INCLUDES_DIR/return-compile.bats
