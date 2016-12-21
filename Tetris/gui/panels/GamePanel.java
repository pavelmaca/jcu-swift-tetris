package tetris.gui.panels;

import tetris.engine.Engine;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.TimerTask;

/**
 * Grafické rozhraní pro herní plochu
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public class GamePanel extends JPanel {

    /* Hodnota FPS */
    private final int FPS = 60;

    /* Časovač pro konstantní překreslování herní plochy */
    private java.util.Timer timer;

    /* Logické část hry */
    private Engine engine;

    /**
     * Inicializace grafického prostředí pro herní plochu.
     * Vytvoření posluchačů pro ovládání hry a časovače.
     *
     * @param engine
     */
    public GamePanel(Engine engine) {
        this.engine = engine;

        timer = new java.util.Timer();
        timer.schedule(new RepaintTask(), 1000, 1000 / FPS);

        addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                super.keyPressed(e);

                switch (e.getKeyCode()) {
                    case KeyEvent.VK_LEFT:
                    case KeyEvent.VK_A:
                        engine.moveLeft();
                        break;
                    case KeyEvent.VK_RIGHT:
                    case KeyEvent.VK_D:
                        engine.moveRight();
                        break;
                    case KeyEvent.VK_DOWN:
                    case KeyEvent.VK_S:
                        engine.moveDown();
                        break;
                    case KeyEvent.VK_UP:
                    case KeyEvent.VK_SPACE:
                    case KeyEvent.VK_W:
                        engine.rotateShape();
                        break;
                }
            }
        });
    }

    /**
     * Překreslení herní plochy podle aktuálního stavu
     *
     * @param g
     */
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);

        // Background
        setBackground(Color.LIGHT_GRAY);

        Color[][] fileds = engine.getStatus();

        // vždy se jedná o čtverec, proto stačí jeden rozměr herní plochy
        int squareSize = getWidth() / engine.getColsCount();

        for (int x = 0; x < engine.getColsCount(); x++) {
            for (int y = 0; y < engine.getRowsCount(); y++) {
                if (fileds[y][x] == null) {
                    continue;
                }

                drawSquare(g, x * squareSize, y * squareSize, squareSize, fileds[y][x]);
            }
        }
    }

    /**
     * Vykreslení jednoho herního bloku (čtverce) a šedého okraje pro zvýraznění.
     *
     * @param g       Rozhraní pro vykreslování uvnitř komponenty
     * @param x       Souřednice osy x
     * @param y       Souřednice osy y
     * @param size    Velikost čtverce
     * @param bgColor Barva pozadí
     */
    private void drawSquare(Graphics g, int x, int y, int size, Color bgColor) {
        g.setColor(bgColor);
        g.fillRect(x, y, size, size);

        g.setColor(Color.GRAY);
        g.drawRect(x, y, size, size);
    }

    /**
     * Úloha časovače pro řízení překreslování a logického posunu objektů
     */
    private class RepaintTask extends TimerTask {

        /* Počítadlo pro zpoždění pohybu objektů */
        int tickNumber = 0;

        @Override
        public void run() {
            tickNumber++;
            // Rychlost pádu podle obtížnosti odvozená od FPS
            if (tickNumber >= (engine.getDifficulty().getFallSpeed() * FPS) / 1000) {
                tickNumber = 0;
                engine.tick();
            }

            repaint();
        }
    }
}
