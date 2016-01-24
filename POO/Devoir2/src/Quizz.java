
import java.util.Scanner;

/**
 * @brief Quizz.
 *
 * @encoding UTF-8
 * @date 8 déc. 2015 at 21:18:42
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class Quizz {

    public static final int REPONSE_PAR_DEFAUT = 0;
    public static final int MAX_POINT = 37;
    private int point; // Entre 0 et MAX_POINT

    /**
     * @fn public Quizz()
     *
     * @brief Default constructor of Quizz
     */
    public Quizz() {
        point = 0;
    }

    public void poser() {
        Scanner sc = new Scanner(System.in);
        String repS;
        int repI, tmpI;
        double repD, tmpD;
        boolean trouve = false;

        for (int i = 0; i < Question.questions.length; i++) {
            System.out.println(Question.questions[i]);
            switch (i) {
                case 0:
                    repS = sc.next();

                    for (String value : Reponse.reponses[i]) {
                        if (repS.equals(value)) {
                            updatePoint(i, true);
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
                    tmpI = Integer.parseInt(Reponse.reponses[i][REPONSE_PAR_DEFAUT]);

                    if (repI >= tmpI - 2 && repI <= tmpI + 2) {
                        updatePoint(i, true);
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
                    tmpD = Double.parseDouble(Reponse.reponses[i][REPONSE_PAR_DEFAUT]) / 100;

                    if (repD >= tmpD * 95 && repD <= tmpD * 105) {
                        updatePoint(i, true);
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
                            updatePoint(i, true);
                        } else {
                            updatePoint(i, false);
                        }
                    }
                    break;
                case 4:
                    for (int k = 0; k < Reponse.MAX_CINQUIEME_REPONSE; k++) {
                        repI = sc.nextInt();

                        if (!Reponse.CINQUIEME_REPONSE.contains(repI) && Reponse.TESTER_CINQUIEME_REPONSE(repI)) {
                            Reponse.CINQUIEME_REPONSE.add(repI);
                            updatePoint(i, true);
                        } else {
                            updatePoint(i, false);
                        }
                    }
                    break;
            }

        }
        if (point < 0) {
            point = 0;
        }
        System.out.println("FINI : Vous avez marqué " + point + " sur " + MAX_POINT);

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
                point += 2;
                break;
            case 1:
                point += 2;
                break;
            case 2:
                point += 3;
                break;
            case 3:
                if (bool) {
                    point += 2;
                } else {
                    point -= 1;
                }
                break;
            case 4:
                if (bool) {
                    point += 2;
                } else {
                    point -= 1;
                }
                break;
        }
    }

}
