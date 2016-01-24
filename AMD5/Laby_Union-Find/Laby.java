
import java.util.HashMap;
import java.util.Random;

public class Laby {

    public static boolean debug = false;

    public static void main(String[] args) {
        System.out.println("makeLabyA");
        Grid myLaby = Laby.makeLabyA(30, 10);
        myLaby.showGrid();
        System.out.println("\n\nmakeLaby");
        myLaby = Laby.makeLaby(30, 10);
        myLaby.showGrid();
    }

    @SuppressWarnings("empty-statement")
    public static Grid makeLabyA(int rows, int columns) {
        Grid myGrid = new Grid(rows, columns);
        HashMap<Integer, Cellule> setNonConnected;
        Cellule cell, neighbor, start, end;
        int rand;
        int test = 0;

        start = myGrid.cell[0][0];
        end = myGrid.cell[myGrid.rows - 1][myGrid.columns - 1];

        while (!UnionFind.Find(UnionFind.Root(start), UnionFind.Root(end))) {
            for (int i = 0; i < myGrid.rows; i++) {
                for (int j = 0; j < myGrid.columns; j++) {
                    cell = myGrid.cell[i][j];
                    setNonConnected = getSetNotConnectedCell(cell);
                    if (setNonConnected != null && !setNonConnected.isEmpty()) {
                        while ((neighbor = setNonConnected.get(rand = new Random().nextInt(Cellule.NEIGHBOR_LENGTH))) == null);
                        cell.breakWallWith(rand);
                        UnionFind.Union(neighbor, cell);
                    }
                }
            }
            test++;
        }

        System.out.println(test);

        return myGrid;
    }

    @SuppressWarnings("empty-statement")
    public static Grid makeLaby(int rows, int columns) {
        Grid myGrid = new Grid(rows, columns);
        HashMap<Integer, Cellule> setNonConnected;
        Cellule[] arrayPermutation;
        Cellule cell, neighbor, tmp, start, end;
        int rand, k = 0;
        int test = 0;

        arrayPermutation = new Cellule[myGrid.rows * myGrid.columns];

        for (int i = 0; i < myGrid.rows; i++) {
            for (int j = 0; j < myGrid.columns; j++) {
                arrayPermutation[k++] = myGrid.cell[i][j];
            }
        }

        for (int i = 0; i < arrayPermutation.length; i++) {
            int j = new Random().nextInt(arrayPermutation.length - 1);
            tmp = arrayPermutation[i];
            arrayPermutation[i] = arrayPermutation[j];
            arrayPermutation[j] = tmp;
        }

        start = myGrid.cell[0][0];
        end = myGrid.cell[myGrid.rows - 1][myGrid.columns - 1];

        while (!UnionFind.Find(UnionFind.Root(start), UnionFind.Root(end))) {
            for (int i = 0; i < myGrid.rows; i++) {
                for (int j = 0; j < myGrid.columns; j++) {
                    setNonConnected = getSetNotConnectedCell(cell = myGrid.cell[i][j]);
                    if (setNonConnected != null && !setNonConnected.isEmpty()) {
                        while ((neighbor = setNonConnected.get(rand = new Random().nextInt(Cellule.NEIGHBOR_LENGTH))) == null);
                        cell.breakWallWith(rand);
                        UnionFind.Union(neighbor, cell);
                    }
                }
            }
            test++;
        }

        System.out.println(test);

        return myGrid;
    }

    /**
     *
     * @brief Calcul et renvoie une hashmap des voisins non connectés à cell.
     *
     * @param cell
     * @return HashMap
     */
    private static HashMap<Integer, Cellule> getSetNotConnectedCell(Cellule cell) {
        HashMap<Integer, Cellule> setNonConnected = new HashMap<>();
        Cellule neighbor_cell;
        Neighbor neighbor;

        for (int k = 0; k < Cellule.NEIGHBOR_LENGTH; k++) {
            if (cell.hasNeighbor(k) && (neighbor = cell.getNeighbor(k)).isWall()) {
                if (!UnionFind.Root(cell).equals(UnionFind.Root(neighbor_cell = neighbor.getCell()))) {
                    setNonConnected.put(k, neighbor_cell);
                }
            }
        }
        return setNonConnected;
    }
}
