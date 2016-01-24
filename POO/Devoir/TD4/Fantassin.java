import java.util.Random;

/**
 * @brief Fantassin.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 18:42:33
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Fantassin extends Personne implements Guerrier {

    private final int degat; //Compris entre 1 et la moitié des pdv du fantassin.

    public Fantassin(String nom, int argent, int pdv) throws ExceptionClone {
        super(nom, argent, pdv);
        this.degat = new Random().nextInt(this.pdv / 2) + 1;
    }

    /**
     * @fn public int forceAttaque()
     *
     * @brief Renvoie les dégats que peut inflicher le fantassin.
     *
     * @return int
     */
    public int forceAttaque() {
        return this.degat;
    }

    /**
     * @fn public void attaque(Personne p) throws ExceptionSuicide
     *
     * @brief Dépouille une personne. Si celle-ci est un chevalier alors le
     * fantassin le capture.
     *
     *
     * @param p
     *
     * @throws ExceptionSuicide
     */
    @Override
    public void attaque(Personne p) throws ExceptionSuicide, ExceptionMort {
        if (!this.equals(p)) {
            if (p.estVivant()) {
                if (p instanceof Chevalier) {
                    ((Chevalier) p).capturer();
                    demanderRancon(((Chevalier) p));
                } else {
                    p.retirerPointDeVie(this.degat);
                }
            } else {
                throw new ExceptionMort();
            }
        } else {
            throw new ExceptionSuicide();
        }
    }

    public void demanderRancon(Chevalier p) {
        if (p.payerRancon(this.degat, this)) {
            System.out.println(p.getNom() + " paye la rançon à " + this.nom);
            p.liberer();
        } else {
            System.out.println("Incapable de payer la rançon. " + this.nom + " tue " + p.getNom());
            p.retirerPointDeVie(p.getPointDeVie());
        }
    }

}
