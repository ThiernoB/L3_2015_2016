import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @brief Main.
 *
 * @encoding UTF-8
 * @date 29 oct. 2015 at 18:57:55
 * @author rgv26 : Pierre Dibo, Universite Diderot Paris 7 - L3 Informatique
 * @email rgv26.warforce@hotmail.fr
 */
public class Main {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Chevalier c1 = null, c2 = null;
        Archer a1 = null;
        Fantassin f1 = null;
        Condotierre cond;

        try {
            c1 = new Chevalier("Pierre", 100, 100);
            c2 = new Chevalier("Richard", 5, 100);
            a1 = new Archer("Jean", 200, 100);
            f1 = new Fantassin("Paul", 100, 50);
        } catch (ExceptionClone ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            cond = new Condotierre("Condotierre", 1000, 100);
        } catch (ExceptionClone ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (c1 != null && c2 != null) {
            try {
                c1.attaque(c2);
            } catch (ExceptionSuicide | ExceptionMort ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (a1 != null && c1 != null) {
            try {
                a1.attaque(c1);
            } catch (ExceptionSuicide | ExceptionMort ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (f1 != null && c2 != null) {
            try {
                f1.attaque(c2);
            } catch (ExceptionSuicide | ExceptionMort ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
