package tetris.engine.events;

/**
 * Rozhraní popisujíco dostupné herní události
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public interface GameStatusListener {

    /**
     * Událost reprezentující změnu skóre
     *
     * @param score aktuální skóre
     */
    void scoreChange(int score);

    /**
     * Událost reprezentující konec hry
     */
    void gameEnd();

    /**
     * Událost reprezentující změnu aktuálního tvaru
     */
    void shapeChange();
}
