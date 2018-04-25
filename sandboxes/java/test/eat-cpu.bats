#inline timeout-preamble.bash

function input_source {
  cat <<EOF
import java.util.ArrayList;

public class Main {

    public static void main(String... args) throws InterruptedException {
        ArrayList<Thread> threads = new ArrayList<>();
        for(int i = 0; i < 10000; i++) {
            Thread t = new Thread(() -> {
                int j = 0;
                while(true) {
                    j++;
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
}
