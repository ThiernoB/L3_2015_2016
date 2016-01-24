/**
 * @brief Archer.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 18:42:37
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Archer extends Personne implements Guerrier {

    public Archer(String nom, int argent, int pdv) throws ExceptionClone {
        super(nom, argent, pdv);
    }

    /**
     * Tue une personne.
     */
    @Override
    public void attaque(Personne p) throws ExceptionSuicide, ExceptionMort {
        if (!this.equals(p)) {
            if (p.estVivant()) {
                p.retirerPointDeVie(p.getPointDeVie());
                System.out.println(this.nom + " tue " + p.nom);
            } else {
                throw new ExceptionMort();
            }
        } else {
            throw new ExceptionSuicide();
        }
    }

}
