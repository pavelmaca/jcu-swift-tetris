/**
 * Výchozí implementace rozhraní {@link GameStatusListener}
 * Při vyvolání událostí není provedena žádná akce.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 * @see GameStatusListener
 */
public class GameStatusAdapter : GameStatusListener {

    /**
     * {@inheritDoc}
     */
    public func scoreChange(score:Int) {
    }

    /**
     * {@inheritDoc}
     */
    public func gameEnd() {
    }

    /**
     * {@inheritDoc}
     */
    public func shapeChange() {
    }
}
