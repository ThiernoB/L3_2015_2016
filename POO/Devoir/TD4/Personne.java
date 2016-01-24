import java.util.Objects;
import java.util.UUID;

public class Personne {

    protected UUID id; //Permet l'identification de chaque objet de la classe crées.
    protected final String nom; //Ne peut être ni null ni vide.
    protected int argent; //Positif ou null.
    protected int pdv; //Compris entre 0 et 100.

    public Personne(String nom, int argent, int pdv) throws ExceptionClone {
        if (nom == null || nom.isEmpty() || pdv <= 0 || pdv > 100 || argent < 0) {
            throw new IllegalArgumentException();
        }

        if (Condotierre.exists) {
            throw new ExceptionClone("Condotierre existe déjà, on ne peut créer de clone de quelqu'un");
        }

        this.id = UUID.randomUUID();
        this.nom = nom;
        this.argent = argent;
        this.pdv = pdv;
    }

    /* Getters */
    public UUID getID() {
        return this.id;
    }

    public String getNom() {
        return this.nom;
    }

    public int getArgent() {
        return this.argent;
    }

    public int getPointDeVie() {
        return this.pdv;
    }

    /**
     * @fn public boolean ajouterArgent(int montant)
     *
     * @brief ajout d'un montant à l'argent d'une personne, si celle-ci est
     * vivante et que la valeur de montant soit positive et inférieur à 100.
     *
     * @param montant
     * @return boolean
     */
    public boolean ajouterArgent(int montant) {
        if (this.estVivant()) {
            if (montant >= 0 && montant <= 100) {
                this.argent += montant;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * @fn public boolean retirerArgent(int montant)
     *
     * @brief retire un montant à l'argent d'une personne si celle-ci est
     * vivante et que la valeur du montant soit positive.
     *
     * @param montant
     * @return boolean
     */
    public boolean retirerArgent(int montant) {
        if (this.estVivant()) {
            if (montant >= 0) {
                this.argent -= montant > this.argent ? this.argent : montant;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * @fn public boolean retirerPointDeVie(int blessure)
     *
     * @brief retire des points de vie d'une personne si celle-ci est vivante et
     * que la valeur de la blessure soit positive.
     *
     * @param blessure
     * @return boolean
     */
    public boolean retirerPointDeVie(int blessure) {
        if (this.estVivant()) {
            if (blessure >= 0) {
                this.pdv -= blessure > this.pdv ? this.pdv : blessure;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * @fn public boolean estVivant()
     *
     * @brief Vérifie si la personne est vivante.
     *
     * @return boolean
     */
    public boolean estVivant() {
        return (this.pdv > 0);
    }

    @Override
    public String toString() {
        return "Nom : " + this.nom + ", argent : " + this.argent + ", vie : " + this.pdv;
    }

    @Override
    public boolean equals(Object o) {
        return (o != null && o.getClass().equals(this.getClass()))
                && (((Personne) o).getID().equals(this.id));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + Objects.hashCode(this.id);
        return hash;
    }

}
