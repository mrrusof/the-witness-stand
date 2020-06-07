#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

source_program=$(cat <<"EOF"
import java.util.LinkedList;

public class Main {

    public static void main(String... args) throws InterruptedException {
        LinkedList<Thread> threads = new LinkedList<>();
        for(int i = 0; i < 10000; i++) {
            Thread t = new Thread(() -> {
                int j = 0;
                LinkedList<Integer> nn = new LinkedList<>();
                while(true) {
                    nn.add(j++);
                }
            });
            t.start();
            threads.add(t);
        }
        for(Thread t : threads) {
            t.join();
        }
    }
}
EOF
)
