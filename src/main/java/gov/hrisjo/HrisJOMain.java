package gov.hrisjo;

/**
 *
 * @author felixiong
 */
public class HrisJOMain {

    private static java.nio.channels.FileLock fileLock;
    
    /**
     * @param args the command line arguments
     * @throws java.io.IOException
     * @throws java.lang.InterruptedException
     */
    public static void main(String[] args) throws java.io.IOException, InterruptedException {
//        javax.swing.UIManager.LookAndFeelInfo[] looks = javax.swing.UIManager.getInstalledLookAndFeels();
//        for (javax.swing.UIManager.LookAndFeelInfo look : looks) {
//            System.out.println(look.getClassName());
//        }
        if (args.length == 0) {
            javax.swing.JOptionPane.showMessageDialog(null, "Server not specified.", "HRIS JOB ORDER", javax.swing.JOptionPane.INFORMATION_MESSAGE);
            System.exit(0);
        }
        System.setProperty("SERVER", args[0]);
        if (args.length > 1) {
            System.setProperty("ACCESS", args[1]);
            MainJFrame.main();
        } else {
            try {
                fileLock = new java.io.FileOutputStream(System.getProperty("java.io.tmpdir") + "/joHRis.file").getChannel().tryLock();
                if (fileLock == null) {
                    javax.swing.JOptionPane.showMessageDialog(null, "JOB ORDER Application is already running.", "Previous Instance", javax.swing.JOptionPane.INFORMATION_MESSAGE);
                    System.exit(0);
                }
                LoginDialog.main();



            } catch (java.awt.HeadlessException | java.io.IOException ex) {
                javax.swing.JOptionPane.showMessageDialog(null, ex.getMessage(), "JOB ORDER", javax.swing.JOptionPane.WARNING_MESSAGE);
                java.util.logging.Logger.getLogger(HrisJOMain.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
            } finally {

            }
        }
    }
}
