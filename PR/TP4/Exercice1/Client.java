
import java.net.Socket;
import java.net.InetSocketAddress;
import java.io.OutputStreamWriter;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.Scanner;

public class Client implements Runnable {

    private final String name;
    private final int port;

    public static void main(String[] args) {
        Client client;
        int port;

        if (args == null || args.length < 1) {
            port = Constant.DEFAULT_PORT;
        } else {
            try {
                port = Integer.parseInt(args[0]);
            } catch (NumberFormatException ex) {
                port = Constant.DEFAULT_PORT;
            }
        }

        client = new Client("localhost", port);
        client.run();
    }

    public Client(String name, int port) {
        this.name = name;
        this.port = port;
    }

    @Override
    public void run() {
        BufferedReader reader;
        PrintWriter writer;
        String str;
        boolean isFind = false;

        try (Socket socket = new Socket()) {
            socket.connect(new InetSocketAddress(this.name, this.port));
            reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            writer = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));

            while (!isFind) {
                System.out.println("Deviner le nombre :");
                writer.println(new Scanner(System.in).nextInt());
                writer.flush();
                str = reader.readLine();

                switch (str) {
                    case "+":
                        System.out.println("C'est plus");
                        break;
                    case "-":
                        System.out.println("C'est moins");
                        break;
                    case "=":
                        System.out.println("C'est egal");
                        isFind = true;
                        break;
                    default: //Should not be reached
                        System.err.println("Should not be reached");
                        return;

                }
            }
            reader.close();
            writer.close();
            socket.close();
        } catch (Exception ex) {
        }
    }

}
