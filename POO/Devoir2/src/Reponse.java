
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @brief Reponse. Ensemble des réponses aux questions.
 *
 * @encoding UTF-8
 * @date 8 déc. 2015 at 21:18:48
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Reponse {

    public static final String[] PREMIERE_REPONSE
            = {"Yunes", "Aissat", "Degorre"};
    public static final String[] DEUXIEME_REPONSE
            = {"67"};
    public static final String[] TROISIEME_REPONSE
            = {"11.35"};

    public static final String[][] reponses
            = {PREMIERE_REPONSE, DEUXIEME_REPONSE, TROISIEME_REPONSE};

    private static final List<String> VALUE_QUATRIEME_REPONSE = Arrays.asList(new String[]{"Terre", "Mars", "Jupiter", "Venus", "Saturne", "Mercure", "Neptune", "Uranus"});

    public static final int MAX_QUATRIEME_REPONSE = 5;
    public static final List<String> QUATRIEME_REPONSE = new ArrayList<>();

    /**
     * @brief Test si la réponse donné est une planete.
     *
     * @param reponse
     * @return boolean
     */
    public static final boolean TESTER_QUATRIEME_REPONSE(String reponse) {
        if (!QUATRIEME_REPONSE.contains(reponse) && VALUE_QUATRIEME_REPONSE.contains(reponse)) {
            QUATRIEME_REPONSE.add(reponse);
            return true;
        } else {
            return false;
        }
    }
    public static final int MAX_CINQUIEME_REPONSE = 10;
    public static final List<Integer> CINQUIEME_REPONSE = new ArrayList<>();

    /**
     * @brief Test si l'entier donné est un nombre premier.
     *
     * @param nombre
     * @return boolean
     */
    public static final boolean TESTER_CINQUIEME_REPONSE(int nombre) {
        boolean estPremier = true;
        if (nombre < 0) {
            estPremier = false;
        } else if (nombre != 0 && nombre != 1) {
            for (int i = 2; i <= nombre / 2; i++) {
                if (nombre != i && nombre % i == 0) {
                    estPremier = false;
                    break;
                }
            }
        }
        return estPremier;
    }

}
