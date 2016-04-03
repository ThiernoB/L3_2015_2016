package exercice1;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.util.Scanner;

/**
 *
 * @author rgv26
 */
public class Serveur {

    private static final int BUFSIZ = 1024;

    @SuppressWarnings("empty-statement")
    public static void main(String[] args) {
        Scanner sc;
        byte[] data;
        DatagramPacket paquet;
        int port;

        sc = new Scanner(System.in);
        data = new byte[BUFSIZ];

        if (args.length == 1) {
            port = new Integer(args[1]);
        } else {
            System.out.println("Entrez un numero de port entre 0 et 9999");
            while ((port = sc.nextInt()) < 0 || port > 9999);
        }

        try (DatagramSocket sock = new DatagramSocket(port)) {
            paquet = new DatagramPacket(data, data.length);
            while (true) {
                sock.receive(paquet);
                System.out.println(paquet.getAddress().getHostAddress()
                        + ":"
                        + paquet.getPort()
                        + "\t"
                        + new String(paquet.getData()));
            }
        } catch (Exception e) {
        }
    }
}
