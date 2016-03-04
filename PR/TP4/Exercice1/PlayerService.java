
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Random;

/**
 * @brief PlayerService.
 *
 * @encoding UTF-8
 * @date 16 févr. 2016 at 10:15:28
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class PlayerService implements Runnable {

    private static final String NEG = "-", PLUS = "+", EQUAL = "=";
    private final Socket socket;
    public static int integer = new Random().nextInt(101);

    public PlayerService(Socket skt) {
        this.socket = skt;
        System.out.println("INTEGER = " + integer);
    }

    @Override
    public void run() {
        BufferedReader reader;
        PrintWriter writer;
        String str;
        int number;
        boolean isFind = false;

        try {
            reader = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            writer = new PrintWriter(new OutputStreamWriter(this.socket.getOutputStream()));

            while (!isFind) {
                str = reader.readLine();
                number = Integer.parseInt(str);

                System.out.println(this.socket.getLocalAddress().getHostName() + " propose : " + number);

                if (number < integer) {
                    writer.println(PLUS);
                    writer.flush();
                } else {
                    if (number > integer) {
                        writer.println(NEG);
                        writer.flush();
                    } else {
                        writer.println(EQUAL);
                        writer.flush();
                        isFind = true;
                        reader.close();
                        writer.close();
                    }
                }
            }
        } catch (IOException ex) {
        }

    }

}
