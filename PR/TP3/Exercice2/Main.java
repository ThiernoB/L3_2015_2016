public class Main {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Jdaytime local = new Jdaytime("localhost");
        Jdaytime lucien = new Jdaytime("lucien");
        Jdaytime nivose = new Jdaytime("nivose");
        

        local.run();
        lucien.run();
        nivose.run();
    }

}
