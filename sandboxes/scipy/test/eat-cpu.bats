#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
from threading import Thread

def work():
    i = 0
    while(True):
        i += 1

threads = []
for i in range(10000):
    t = Thread(target = work)
    threads.append(t)
    t.start()

for t in threads:
    t.join()
EOF
)
