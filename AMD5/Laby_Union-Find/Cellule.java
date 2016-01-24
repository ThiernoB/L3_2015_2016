
import java.util.Arrays;
import java.util.Objects;

public class Cellule {

    public final static int WEST = 0;
    public final static int EAST = 5;
    public final static int SOUTHEAST = 2;
    public final static int SOUTHWEST = 4;
    public final static int NORTHEAST = 1;
    public final static int NORTHWEST = 3;
    public final static int NEIGHBOR_LENGTH = 6;

    public static int neighborTo(int i) {
        return (5 - i);
    }

    private Neighbor[] neighbors = new Neighbor[6];
    private Integer id;
    private Cellule parent;
    private int weight;

    /*Constructors*/
    @SuppressWarnings("LeakingThisInConstructor")
    public Cellule(Integer n) {
        this.id = n;
        this.parent = this;
        this.weight = 1;
    }

    @SuppressWarnings("LeakingThisInConstructor")
    public Cellule(Integer n, Cellule[] cells) {
        this.id = n;
        this.parent = this;
        this.weight = 1;
        for (int i = 0; i < 6; i++) {
            if (cells[i] != null) {
                this.setNeighbor(i, cells[i]);
            }
        }
    }

    /*Get methods*/
    public Integer getId() {
        return this.id;
    }

    public Cellule getParent() {
        return this.parent;
    }

    public int getWeight() {
        return this.weight;
    }

    public Boolean hasNeighbor(int i) {
        return (this.neighbors[i].getCell() != null);
    }

    public Neighbor getNeighbor(int i) {
        return this.neighbors[i];
    }

    public Integer getNeighborId(int i) {
        if (this.hasNeighbor(i)) {
            return this.neighbors[i].getCell().getId();
        } else {
            return -1;
        }
    }

    public void setParent(Cellule newParent) {
        this.parent = newParent != null ? newParent : this;
    }

    public void setWeight(int new_weight) {
        this.weight = new_weight < 0 ? 0 : new_weight;
    }

    public void upWeight(int up) {
        if (up >= 0) {
            setWeight(this.weight + up);
        }
    }

    public void setNeighbor(int orientation, Cellule nbr) {
        this.neighbors[orientation] = new Neighbor(nbr);
    }

    public void breakWallWith(int i) {
        if (this.hasNeighbor(i)) {
            this.neighbors[i].breakWall();
            this.neighbors[i].getCell().neighbors[neighborTo(i)].breakWall();
        } else if (Laby.debug) {
            System.err.println("No such neighbor");
        }
    }

    /*Print method*/
    public void printNeighborhood() {
        System.out.println("     / \\ / \\");
        System.out.println("    |" + Auxiliaire.numInThree(this.getNeighborId(Cellule.NORTHWEST)) + "|" + Auxiliaire.numInThree(this.getNeighborId(Cellule.NORTHEAST)) + "|");
        System.out.println("   / \\ / \\ / \\");
        System.out.println("  |" + Auxiliaire.numInThree(this.getNeighborId(Cellule.WEST)) + "|" + Auxiliaire.numInThree(this.getId()) + "|" + Auxiliaire.numInThree(this.getNeighborId(Cellule.EAST)) + "|");
        System.out.println("   \\ / \\ / \\ /");
        System.out.println("    |" + Auxiliaire.numInThree(this.getNeighborId(Cellule.SOUTHWEST)) + "|" + Auxiliaire.numInThree(this.getNeighborId(Cellule.SOUTHEAST)) + "|");
        System.out.println("     \\ / \\ /");
    }

    /*Override methods*/
    @Override
    public boolean equals(Object o) {
        return (o != null && o.getClass().equals(this.getClass()) && ((Cellule) o).id.equals(this.id));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 89 * hash + Arrays.deepHashCode(this.neighbors);
        hash = 89 * hash + Objects.hashCode(this.id);
        hash = 89 * hash + Objects.hashCode(this.parent);
        hash = 89 * hash + this.weight;
        return hash;
    }

    @Override
    public String toString() {
        return "" + this.id;
    }
}
