import java.util.LinkedList;

public class Noble extends Personne {

    private final LinkedList<Roturier> roturiers;

    public Noble(String nom, int argent, int pdv) throws ExceptionClone {
        super(nom, argent, pdv);
        roturiers = new LinkedList<>();
    }

    public void tax() {
        roturiers.stream().filter((p) -> (p.estVivant())).map((p) -> {
            ajouterArgent(p.getArgent() / 2);
            return p;
        }).forEach((p) -> {
            p.retirerArgent(p.getArgent() / 2);
        });
    }

    public void ajouterRoturier(Roturier p) {
        roturiers.addLast(p);
    }

    @Override
    public String toString() {
        String nobleStr = "[Noble] " + super.toString();
        String peonsStr = "Roturiers :\n";
        for (Roturier p : roturiers) {
            peonsStr = peonsStr.concat(p.toString() + "\n");
        }
        return nobleStr + "\n" + peonsStr;
    }

}
