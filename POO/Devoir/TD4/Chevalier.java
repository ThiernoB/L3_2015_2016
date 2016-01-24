/**
 * @brief Chevalier.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 18:42:24
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Chevalier extends Noble implements Guerrier {

    private boolean estLibre;

    public Chevalier(String nom, int argent, int pdv) throws ExceptionClone {
        super(nom, argent, pdv);
        this.estLibre = true;
    }

    /**
     *
     *
     * @param p
     * @throws ExceptionSuicide
     * @throws ExceptionMort
     */
    @Override
    public void attaque(Personne p) throws ExceptionSuicide, ExceptionMort {
        if (!this.equals(p)) {
            if (p.estVivant()) {
                if (p instanceof Chevalier) {
                    if (this.capture(((Chevalier) p))) {
                        System.out.println(this.nom + " capture " + p.nom);
                    } else {
                        System.out.println(p.nom + " est déjà capturer");
                    }
                } else {
                    System.out.println("La personne que l'on veut attaquer n'est pas un chevalier.\n");
                }
            } else {
                throw new ExceptionMort();
            }
        } else {
            throw new ExceptionSuicide();
        }
    }

    public boolean capture(Chevalier c) {
        if (c.estLibre) {
            c.capturer();
            return true;
        }
        return false;
    }

    /**
     * @fn public void capturer()
     *
     * @brief Le chevalier n'est plus libre.
     */
    public void capturer() {
        this.estLibre = false;
    }

    /**
     *
     * @fn public void libere()
     *
     * @brief Le chevalier redevient libre.
     */
    public void liberer() {
        this.estLibre = true;
    }

    /**
     * @fn public boolean estLibre()
     *
     * @brief Vérifie si le chevalier est libre.
     *
     * @return boolean
     */
    public boolean estLibre() {
        return this.estLibre;
    }

    public boolean payerRancon(int n, Personne p) {
        return (this.argent > n && p.ajouterArgent(n) && this.retirerArgent(n));
    }

    @Override
    public boolean equals(Object o) {
        if (o != null && o.getClass().equals(this.getClass())) {
            return super.equals(o) && ((Chevalier) o).estLibre() == this.estLibre;
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + (this.estLibre ? 1 : 0);
        return hash;
    }

}
