
import java.util.Stack;

/**
 * @brief UnionFind.
 *
 * @encoding UTF-8
 * @date 23 oct. 2015 at 11:26:56
 * @author rgv26
 * @email rgv26.warforce@hotmail.fr
 */
public class UnionFind {


    /*Public methods*/
    public static Cellule Root(Cellule cell) {
        if (cell == null) {
            throw new RuntimeException("Container null");
        }
        if (cell.getParent() != cell) {
            cell = Root(cell.getParent());
        }
        return cell;
    }

    public static boolean Find(Cellule cell1, Cellule cell2) {
        return (Root(cell1) == Root(cell2));
    }

    public static void Union(Cellule cell1, Cellule cell2) {
        if (!Find(cell1, cell2)) {
            SetParentCells(Root(cell1), Root(cell2));
        }
    }

    /*Private methods*/
    private static void SetParentCells(Cellule root1, Cellule root2) {
        int root1Size = root1.getWeight();
        int root2Size = root2.getWeight();

        if (root1Size >= root2Size) {
            root2.getParent().setParent(root1);
            root1.upWeight(root2Size);
        } else {
            root1.getParent().setParent(root2);
            root2.upWeight(root1Size);
        }
    }

}
