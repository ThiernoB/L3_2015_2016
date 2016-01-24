import java.util.Stack;

/**
 * @brief Joueur.
 *
 * @encoding UTF-8
 * @date 11 oct. 2015 at 17:20:31
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public abstract class Joueur {

     Stack<Integer> transcript;

    public Joueur() {
        this.transcript = new Stack<>();
    }

    public void receive(Integer msg) {
        this.transcript.push(msg);
    }

}
