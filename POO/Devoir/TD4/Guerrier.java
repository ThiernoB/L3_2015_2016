/**
 * @brief Guerrier.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 18:42:44
 * @author rgv26
 */
public interface Guerrier {

    /**
     * @fn public void attaque(Personne p) throws ExceptionSuicide
     *
     * @brief Attaque une personne.
     *
     * @param p
     *
     * @throws ExceptionSuicide
     * @throws TD4.ExceptionMort
     */
    public void attaque(Personne p) throws ExceptionSuicide, ExceptionMort;

}
