import java.util.Scanner;

/**
 * @brief ReseauAdversairePassif.
 *
 * @encoding UTF-8
 * @date 8 nov. 2015 at 23:27:47
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class ReseauAdversairePassif {

    Scanner sc;
    private final JoueurEncrypted adversaire;

    public ReseauAdversairePassif(Joueur j1, Joueur j2, EncryptionProtocol encr, int key) {
        sc = new Scanner(System.in);
        adversaire = new JoueurEncrypted(encr, key);
        if (j1 == null || j2 == null) {
            throw new IllegalArgumentException();
        }
        init(j1, j2);

        System.out.println("Message(s) reçue par l'adversaire :");
        adversaire.read();
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
                            ((JoueurEncrypted) j1).communicate(j2, val = sc.nextInt());
                            ((JoueurEncrypted) j1).communicate(adversaire, val);
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
                            ((JoueurEncrypted) j2).communicate(j1, val = sc.nextInt());
                            ((JoueurEncrypted) j2).communicate(adversaire, val);
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
