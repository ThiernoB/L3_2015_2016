import java.util.Scanner;

/**
 * @brief ReseauAdversaireActif.
 *
 * @encoding UTF-8
 * @date 8 nov. 2015 at 23:28:32
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class ReseauAdversaireActif {

    Scanner sc;
    private final JoueurEncrypted adversaire;

    public ReseauAdversaireActif(Joueur j1, Joueur j2, EncryptionProtocol encr, int key) {
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
        int val1, val2;

        while (true) {
            do {
                System.out.println("Pour etre joueur 1 taper 1.");
                System.out.println("Pour etre joueur 2 taper 2.");
                System.out.println("Pour quitter taper 0.");
                val1 = sc.nextInt();
            } while (val1 < 0 || val1 > 2);

            if (val1 == 0) {
                return;
            }

            switch (val1) {
                case 1:
                    do {
                        System.out.println("Joueur 1 :");
                        System.out.println("Pour tapez un message (valuer numérique) tapez 1");
                        System.out.println("Pour lire vos messages (valuer numérique) tapez 2");
                        val1 = sc.nextInt();
                    } while (val1 < 1 || val1 > 2);
                    switch (val1) {
                        case 1:
                            val1 = sc.nextInt();
                            do {
                                System.out.println("Adversaire : ");
                                System.out.println("Voulez vous modifier le message " + val1 + " ? Si oui tapez 1 sinon 0");
                                val2 = sc.nextInt();
                            } while (val2 < 0 || val2 > 1);

                            if (val2 == 1) {
                                ((JoueurEncrypted) j1).communicate(j2, val1 = sc.nextInt());
                                ((JoueurEncrypted) j1).communicate(adversaire, val1);
                            } else {
                                ((JoueurEncrypted) j1).communicate(j2, val1);
                                ((JoueurEncrypted) j1).communicate(adversaire, val1);
                            }

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
                        val1 = sc.nextInt();
                    } while (val1 < 1 || val1 > 2);
                    switch (val1) {
                        case 1:
                            ((JoueurEncrypted) j2).communicate(j1, val1 = sc.nextInt());
                            ((JoueurEncrypted) j2).communicate(adversaire, val1);

                            val1 = sc.nextInt();
                            do {
                                System.out.println("Adversaire : ");
                                System.out.println("Voulez vous modifier le message " + val1 + " ? Si oui tapez 1 sinon 0");
                                val2 = sc.nextInt();
                            } while (val2 < 0 || val2 > 1);

                            if (val2 == 1) {
                                ((JoueurEncrypted) j2).communicate(j1, val1 = sc.nextInt());
                                ((JoueurEncrypted) j2).communicate(adversaire, val1);
                            } else {
                                ((JoueurEncrypted) j2).communicate(j1, val1);
                                ((JoueurEncrypted) j2).communicate(adversaire, val1);
                            }
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
