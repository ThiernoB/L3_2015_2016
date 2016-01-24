/**
 * @brief EncryptionProtocol.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 17:18:51
 * @author rgv26
 */
public interface EncryptionProtocol {

    public Integer encryption(Integer msg_decr, int key);

    public Integer decryption(Integer msg_encr, int key);

}
