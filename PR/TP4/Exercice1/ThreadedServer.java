
import java.net.ServerSocket;
import java.net.Socket;

/**
 * @brief ThreadedServer.
 *
 * @encoding UTF-8
 * @date 16 févr. 2016 at 10:16:19
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class ThreadedServer implements Runnable {

    private final int port;

    public static void main(String[] args) {
        ThreadedServer serv;
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

        serv = new ThreadedServer(port);
        serv.run();
    }

    public ThreadedServer(int port) {
        this.port = port;
    }

    @Override
    public void run() {
        Thread thread;
        Socket socketClient;

        try (ServerSocket server = new ServerSocket(this.port)) {
            while (true) {
                if ((socketClient = server.accept()) == null) {
                    System.err.println("Server : Intern error");
                    server.close();
                    break;
                }
                System.out.println("Ouvre " + socketClient.getLocalAddress().getHostName());

                (thread = new Thread(new PlayerService(socketClient))).start();
                thread.join();

                System.out.println(socketClient.getLocalAddress().getHostName() + " trouve : " + PlayerService.integer);
                System.out.println("Ferme " + socketClient.getLocalAddress().getHostName());

                socketClient.close();
            }
        } catch (Exception ex) {
        }
    }

}
