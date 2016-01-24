
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

/**
 * @brief BanqueAleatoire. Pose un questionnaire où chaque question sont posé
 * dans le désordre.
 *
 * @encoding UTF-8
 * @date 8 déc. 2015 at 18:26:10
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class BanqueAleatoire {

    public static final int REPONSE_PAR_DEFAUT = 0;
    public static final int MAX_POINT = 37;
    private int points; // Entre 0 et MAX_POINT

    public BanqueAleatoire() {
        points = 0;
    }

    public void poser() {
        Scanner sc = new Scanner(System.in);
        List<Integer> list = new ArrayList<>();
        String repS;
        int questions, repI, tmpI;
        double repD, tmpD;
        boolean trouve = false;

        while (list.size() < Question.questions.length) {
            // Choisit aléatoirement une question
            do {
                questions = new Random().nextInt(Question.questions.length);
            } while (list.contains(questions));

            list.add(questions);
            System.out.println(Question.questions[questions]);

            switch (questions) {
                case 0:
                    repS = sc.next();

                    for (String value : Reponse.reponses[questions]) {
                        if (repS.equals(value)) {
                            updatePoint(questions, true);
                            trouve = true;
                            break;
                        }
                    }
                    if (trouve) {
                        System.out.println("Bonne réponse");
                        trouve = false;
                    } else {
                        System.out.println("Mauvaise réponse");
                    }
                    break;
                case 1:
                    repI = sc.nextInt();
                    tmpI = Integer.parseInt(Reponse.reponses[questions][REPONSE_PAR_DEFAUT]);

                    if (repI >= tmpI - 2 && repI <= tmpI + 2) {
                        updatePoint(questions, true);
                        trouve = true;
                    }
                    if (trouve) {
                        System.out.println("Bonne réponse");
                        trouve = false;
                    } else {
                        System.out.println("Mauvaise réponse");
                    }
                    break;
                case 2:
                    repD = sc.nextDouble();
                    tmpD = Double.parseDouble(Reponse.reponses[questions][REPONSE_PAR_DEFAUT]) / 100;

                    if (repD >= tmpD * 95 && repD <= tmpD * 105) {
                        updatePoint(questions, true);
                        trouve = true;
                    }
                    if (trouve) {
                        System.out.println("Bonne réponse");
                        trouve = false;
                    } else {
                        System.out.println("Mauvaise réponse");
                    }
                    break;
                case 3:
                    for (int k = 0; k < Reponse.MAX_QUATRIEME_REPONSE; k++) {
                        repS = sc.next();

                        if (Reponse.TESTER_QUATRIEME_REPONSE(repS)) {
                            updatePoint(questions, true);
                        } else {
                            updatePoint(questions, false);
                        }
                    }
                    break;
                case 4:
                    for (int k = 0; k < Reponse.MAX_CINQUIEME_REPONSE; k++) {
                        repI = sc.nextInt();

                        if (!Reponse.CINQUIEME_REPONSE.contains(repI) && Reponse.TESTER_CINQUIEME_REPONSE(repI)) {
                            Reponse.CINQUIEME_REPONSE.add(repI);
                            updatePoint(questions, true);
                        } else {
                            updatePoint(questions, false);
                        }
                    }
                    break;
            }
        }
        if (points < 0) {
            points = 0;
        }
        System.out.println("FINI : Vous avez marqué " + points + " sur " + MAX_POINT);
    }

    /**
     * @brief Augmente ou diminue les points.
     *
     * @param i
     * @param bool
     */
    private void updatePoint(int i, boolean bool) {
        if (i > Question.questions.length || i < 0) {
            throw new RuntimeException();
        }

        switch (i) {
            case 0:
                points += 2;
                break;
            case 1:
                points += 2;
                break;
            case 2:
                points += 3;
                break;
            case 3:
                if (bool) {
                    points += 2;
                } else {
                    points -= 1;
                }
                break;
            case 4:
                if (bool) {
                    points += 2;
                } else {
                    points -= 1;
                }
                break;
        }
    }
}
