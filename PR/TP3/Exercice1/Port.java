import java.net.InetSocketAddress;
import java.net.Socket;

public class Port implements Runnable {

    private final String name;

    /**
     * @param name 
     */
    public Port(String name) {
        this.name = name;
    }

    @Override
    public void run() {
        for (int port = 0; port <= 1024; port++) {
            try (Socket socket = new Socket()) {
                socket.connect(new InetSocketAddress(name, port), 1000);
                socket.close();
                System.out.println("Port " + name + " " + port + " is open");
            } catch (Exception ex) {
            }
        }
    }

}

