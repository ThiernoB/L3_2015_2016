import java.util.Scanner;

/**
 * @brief ReseauHonnete.
 *
 * @encoding UTF-8
 * @date 8 nov. 2015 at 21:38:45
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class ReseauHonnete {

    Scanner sc;

    public ReseauHonnete(Joueur j1, Joueur j2) {
        sc = new Scanner(System.in);
        if (j1 == null || j2 == null) {
            throw new IllegalArgumentException();
        }
        init(j1, j2);
    }

    private void init(Joueur j1, Joueur j2) {
        int val;

        while (true) {
            do {
                System.out.println("Pour etre joueur 1 taper 1.");
                System.out.println("Pour etre joueur 2 taper 2.");
                System.out.println("Pour quitter taper 0.");
                val = sc.nextInt();
            } while (val < 0 || val > 2);

            if (val == 0) {
                return;
            }

            switch (val) {
                case 1:
                    do {
                        System.out.println("Joueur 1 :");
                        System.out.println("Pour tapez un message (valuer numérique) tapez 1");
                        System.out.println("Pour lire vos messages (valuer numérique) tapez 2");
                        val = sc.nextInt();
                    } while (val < 1 || val > 2);
                    switch (val) {
                        case 1:
                            ((JoueurEncrypted) j1).communicate(j2, sc.nextInt());
                            break;
                        case 2:
                            ((JoueurEncrypted) j1).read();
                            break;
                        default:
                            System.err.println("Should not be reached");
                            break;
                    }
                    break;
                case 2:
                    do {
                        System.out.println("Joueur 2 :");
                        System.out.println("Pour tapez un message (valuer numérique) tapez 1");
                        System.out.println("Pour lire vos messages (valuer numérique) tapez 2");
                        val = sc.nextInt();
                    } while (val < 1 || val > 2);
                    switch (val) {
                        case 1:
                            ((JoueurEncrypted) j2).communicate(j1, sc.nextInt());
                            break;
                        case 2:
                            ((JoueurEncrypted) j2).read();
                            break;
                        default:
                            System.err.println("Should not be reached");
                            break;
                    }
                    break;
                default:
                    System.err.println("Should not be reached");
                    break;

            }
        }
    }

}
