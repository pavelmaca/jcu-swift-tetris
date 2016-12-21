package tetris.gui;


import tetris.engine.Engine;
import tetris.gui.panels.GamePanel;
import tetris.gui.panels.StatusPanel;

import javax.swing.*;
import java.awt.*;

/**
 * Hlavní okno hry, starající se o vykreslování veškerého grafického rozhraní.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public class Gui {

    /* fdf */
    private JFrame frame;

    private Engine engine;

    private int squereSize;

    public Gui(Engine engine, int squereSize) {
        this.engine = engine;
        this.squereSize = squereSize;
    }

    /**
     * Vytvoření okna, jeho základní nastavení a
     * vykreslení komponent.
     */
    public void render() {
        frame = new JFrame("Tetris");

        // ukončí aplikaci, po zavření tohoto okna
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.X_AXIS));

        renderGame();

        renderStatus();

        frame.setResizable(false);

        frame.pack();

        frame.setLocationRelativeTo(null); // spustí aplikaci ve středu okna

        frame.setVisible(true);
    }

    /**
     * Nastavení a vykreslení komponenty hrací plochy.
     */
    private void renderGame() {
        JPanel gamePanel = new GamePanel(engine);
        frame.add(gamePanel);

        Dimension panelSize = new Dimension();
        panelSize.setSize(engine.getColsCount() * squereSize, engine.getRowsCount() * squereSize);

        gamePanel.setPreferredSize(panelSize);

        gamePanel.setFocusable(true); // nasttavení fokusu pro stisk tlačítek
    }

    /**
     * Nastavení a vykreslení komponenty ovládacího menu a stavu hry.
     */
    private void renderStatus() {
        JPanel statusPanel = new StatusPanel(engine);

        statusPanel.setPreferredSize(new Dimension(125, 10));
        frame.add(statusPanel);
    }

}
