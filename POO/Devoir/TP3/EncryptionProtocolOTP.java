/**
 * @brief EncryptionProtocolOTP.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 17:20:09
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class EncryptionProtocolOTP implements EncryptionProtocol {

    public EncryptionProtocolOTP() {

    }

    @Override
    public Integer encryption(Integer msg_decr, int key) {
        Integer msg_encr = msg_decr ^ key;

        return msg_encr;
    }

    @Override
    public Integer decryption(Integer msg_encr, int key) {
        Integer msg_decr = msg_encr ^ key;

        return msg_decr;
    }
}
