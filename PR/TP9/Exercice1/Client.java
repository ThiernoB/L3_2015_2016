package exercice1;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.util.Scanner;

/**
 *
 * @author rgv26
 */
public class Client {

    @SuppressWarnings("empty-statement")
    public static void main(String[] args) {
        InetSocketAddress ia;
        DatagramPacket paquet;
        Scanner sc;
        String s;
        byte[] data;
        int port;

        sc = new Scanner(System.in);

        if (args.length == 1) {
            port = new Integer(args[1]);
        } else {
            System.out.println("Entrez un numero de port entre 0 et 9999");
            while ((port = sc.nextInt()) < 0 || port > 9999);
        }

        try (DatagramSocket dso = new DatagramSocket()) {
            s = sc.next() + "\n";
            data = s.getBytes();
            ia = new InetSocketAddress(InetAddress.getLocalHost(), port);
            paquet = new DatagramPacket(data, data.length, ia);
            dso.send(paquet);
        } catch (Exception e) {
        }
    }
}
