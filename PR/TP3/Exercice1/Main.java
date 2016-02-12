public class Main {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Port local = new Port("localhost");
        Port lucien = new Port("lucien");
        Port nivose = new Port("nivose");
        
        local.run();
        lucien.run();
        nivose.run();
    }

}

