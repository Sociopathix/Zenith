//============================================================================
/*****************************************************************************
    // This file should not be modified
 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
//============================================================================
import javax.swing.JFrame;

public class Lab1 {

    public static void main(String[] args) throws InterruptedException {
             
	Game game = new Game();
        
        JFrame frame = new JFrame(game.TITLE);
        frame.add(game);
        frame.setSize(game.WIDTH + 30, game.HEIGHT + 60);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        while (true) {
            game.repaint();
            game.update();
            Thread.sleep(10);
        }
    }
    
}
