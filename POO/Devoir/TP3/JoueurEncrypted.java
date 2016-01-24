/**
 * @brief JoueurEncrypted.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 19:26:36
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class JoueurEncrypted extends Joueur implements Reseau {

    private EncryptionProtocol encr;
    private final int privateKey;

    public JoueurEncrypted(EncryptionProtocol encryption, int key) {
        super();
        privateKey = key;
        this.initialise(encryption);
    }

    private void initialise(EncryptionProtocol encryption) {
        encr = encryption;
    }

    public void read() {
        this.transcript.stream().forEach((transcript1) -> {
            System.out.println(encr.decryption(transcript1, privateKey));
        });
    }

    @Override
    public void communicate(Joueur j, Integer msg) {
        j.receive(encr.encryption(msg, privateKey));
    }
}
