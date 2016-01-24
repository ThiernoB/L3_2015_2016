import java.util.LinkedList;

public class Societe {

    private final LinkedList<Personne> personnes;

    public Societe() {
        personnes = new LinkedList<>();
    }

    public void ajouterPersonne(Personne p) {
        personnes.addLast(p);
    }

    public void nouvelleAnnee() {

        LinkedList<Personne> morts = new LinkedList<>();

        personnes.stream().filter((p) -> (!p.estVivant())).forEach((p) -> {
            morts.add(p);
        });

        morts.stream().forEach((p) -> {
            personnes.remove(p);
        });

        personnes.stream().filter((p) -> (p instanceof Roturier)).forEach((p) -> {
            ((Roturier) p).produire();
        });

        personnes.stream().filter((p) -> (p instanceof Noble)).forEach((p) -> {
            ((Noble) p).tax();
        });

        System.out.println(this);

    }

    @Override
    public String toString() {
        String societyStr = "Societe :\n";
        for (Personne p : personnes) {
            societyStr = societyStr.concat(p.toString() + "\n\n");
        }
        return societyStr;
    }

}
