/**
 * Rozhraní popisujíco dostupné herní události
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public protocol GameStatusListener {

    /**
     * Událost reprezentující změnu skóre
     *
     * @param score aktuální skóre
     */
    func scoreChange(score:Int);

    /**
     * Událost reprezentující konec hry
     */
    func gameEnd();

    /**
     * Událost reprezentující změnu aktuálního tvaru
     */
    func shapeChange();
}
