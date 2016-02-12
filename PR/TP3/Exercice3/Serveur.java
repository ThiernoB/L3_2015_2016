
import java.net.Socket;
import java.net.ServerSocket;
import java.io.OutputStreamWriter;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.Random;

public class Serveur implements Runnable {

    private static final String NEG = "-", PLUS = "+", EQUAL = "=";
    private final int integer;
    private final int port;

    public static void main(String[] args) {
        Serveur serv;
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

        serv = new Serveur(port);
        serv.run();
    }

    public Serveur(int port) {
        this.integer = new Random().nextInt(101);
        this.port = port;
        System.out.println("INTEGER = " + this.integer);
    }

    @Override
    public void run() {
        Socket socketClient;
        BufferedReader reader;
        PrintWriter writer;
        String str;
        int number;
        boolean isFind = false;
        try (ServerSocket server = new ServerSocket(this.port)) {

            System.out.println("Serveur " + server.getInetAddress().getHostAddress() + " ouvert au port " + this.port + "\n");

            while (true) {
                if ((socketClient = server.accept()) == null) {
                    System.err.println("Server : Intern error");
                    server.close();
                }
                System.out.println("Ouvre " + socketClient.getLocalAddress().getHostName());
                reader = new BufferedReader(new InputStreamReader(socketClient.getInputStream()));
                writer = new PrintWriter(new OutputStreamWriter(socketClient.getOutputStream()));

                while (!isFind) {
                    str = reader.readLine();
                    number = Integer.parseInt(str);

                    System.out.println(socketClient.getLocalAddress().getHostName() + " propose : " + number);

                    if (number < this.integer) {
                        writer.println(PLUS);
                        writer.flush();
                    } else {
                        if (number > this.integer) {
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
                System.out.println(socketClient.getLocalAddress().getHostName() + " trouve : " + this.integer);
                System.out.println("Ferme " + socketClient.getLocalAddress().getHostName());
                isFind = false;
                socketClient.close();
            }
        } catch (Exception ex) {
        }
    }

}
