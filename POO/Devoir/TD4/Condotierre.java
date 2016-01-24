import java.util.HashMap;
import java.util.Objects;
import java.util.Random;
import java.util.UUID;

/**
 * @brief Condotierre.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 19:41:10
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Condotierre extends Personne implements Guerrier {

    public static final int LENGHT_MAX_GUERRIERS = 10;
    public static int DEFAULT_MONEY = 100;

    public static boolean exists = false;

    public HashMap<UUID, Guerrier> listGuerriers = new HashMap<>();

    public Condotierre(String nom, int argent, int pdv) throws ExceptionClone {
        super(nom, argent, pdv);
        this.bandeMercenaire();
        exists = true;
    }

    /**
     * Crée une bande de mercenaire appartenant à Condotierre. Chaque mercenaire
     * aura pour base d'argent égal à DEFAULT_MONEY.
     */
    private void bandeMercenaire() throws ExceptionClone {
        Guerrier guerrier;
        int rand, nbMercenaires;

        nbMercenaires = new Random().nextInt(LENGHT_MAX_GUERRIERS);
        for (int i = 0; i < nbMercenaires; i++) {
            if (i % 2 == 0) {
                guerrier = new Fantassin("Guerrier" + i, DEFAULT_MONEY, (rand = new Random().nextInt(100)) == 0 ? 1 : rand);
                this.listGuerriers.put(((Fantassin) guerrier).id, guerrier);
            } else {
                guerrier = new Archer("Guerrier" + i, DEFAULT_MONEY, (rand = new Random().nextInt(100)) == 0 ? 1 : rand);
                this.listGuerriers.put(((Archer) guerrier).id, guerrier);
            }
        }
    }

    @Override
    public void attaque(Personne p) throws ExceptionSuicide, ExceptionMort {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean equals(Object o) {
        return (o != null && o.getClass().equals(this.getClass()) && super.equals(o));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 59 * hash + Objects.hashCode(this.listGuerriers);
        return hash;
    }
}
