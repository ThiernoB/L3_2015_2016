public class Roturier extends Personne {

    private final int capaciteProd;

    public Roturier(String nom, int argent, int pdv, int capaciteProd) throws ExceptionClone {
        super(nom, argent, pdv);
        this.capaciteProd = capaciteProd;
    }

    public int getCapaciteProd() {
        return capaciteProd;
    }

    public void produire() {
        if (estVivant()) {
            ajouterArgent(capaciteProd);
        }
    }

    @Override
    public String toString() {
        return super.toString() + ", prod. : " + capaciteProd;
    }
}
