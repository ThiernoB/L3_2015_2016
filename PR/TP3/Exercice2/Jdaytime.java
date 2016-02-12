import java.io.BufferedReader;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.io.InputStreamReader;
import java.net.InetAddress;

public class Jdaytime implements Runnable {

	private static final int DAYTIME = 13;
	private final String name;
	
    public Jdaytime(String name) {
        this.name = name;
    }
    
    @Override
    public void run() {
    	BufferedReader reader = null;
    	String str;
    	
    	try (Socket socket = new Socket()) {
        	socket.connect(new InetSocketAddress(name, DAYTIME), 1000);
        	reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        	
        	str = reader.readLine();
        	
        	System.out.println(name + " : " +str);
        	
        	reader.close();
         	socket.close();	
        } catch (Exception ex) {
        }
    }

}

