import java.util.Random;

/**
 * @brief Main.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 17:16:31
 * @author rgv26 : Pierre Dibo, Universite Diderot Paris 7 - L3 Informatique
 * @email rgv26.warforce@hotmail.fr
 */
public class Main {

    /**
     * @param args
     */
    public static void main(String[] args) {
        int key = new Random().nextInt(Integer.MAX_VALUE);

        EncryptionProtocol encr = new EncryptionProtocolOTP();
        JoueurEncrypted joueurEncrypted1 = new JoueurEncrypted(encr, key);
        JoueurEncrypted joueurEncrypted2 = new JoueurEncrypted(encr, key);

        //ReseauHonnete reseauHonnete = new ReseauHonnete(joueurEncrypted1, joueurEncrypted2);
        //ReseauAdversairePassif reseauAdversairePassif = new ReseauAdversairePassif(joueurEncrypted1, joueurEncrypted2, encr, key);
        //ReseauAdversaireActif reseauAdversaireActif = new ReseauAdversaireActif(joueurEncrypted1, joueurEncrypted2, encr, key);

    }

}
