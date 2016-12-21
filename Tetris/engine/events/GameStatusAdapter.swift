package tetris.engine.events;

/**
 * Výchozí implementace rozhraní {@link GameStatusListener}
 * Při vyvolání událostí není provedena žádná akce.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 * @see GameStatusListener
 */
public abstract class GameStatusAdapter implements GameStatusListener {

    /**
     * {@inheritDoc}
     */
    @Override
    public void scoreChange(int score) {
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void gameEnd() {
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void shapeChange() {
    }
}
