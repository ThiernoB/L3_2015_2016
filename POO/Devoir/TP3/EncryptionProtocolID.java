/**
 * @brief EncryptionProtocolID.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 17:19:42
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class EncryptionProtocolID implements EncryptionProtocol {

    public EncryptionProtocolID() {

    }

    @Override
    public Integer encryption(Integer msg_decr, int key) {
        return msg_decr;
    }

    @Override
    public Integer decryption(Integer msg_encr, int key) {
        return msg_encr;
    }

}
