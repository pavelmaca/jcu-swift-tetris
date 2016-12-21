import Foundation

/**
 * Seznam obtížností
 * jednotlivé obtížnosti obsahují koeficient obtížnosti, použitý pro výpočet skóre a textvoí popis.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public enum Difficulty {
    EASY("Lehká", 1, 350),
    MEDIUM("Střední", 2, 250),
    HARD("Těžká", 3, 200);

    /**
     * Popis obtížnosti
     */
    final String description;

    /**
     * Koeficient obtížnosti
     */
    final int scoreCoeficient;

    /**
     * Rychlost pádu (prodleva mezi pohyby objektů) v milisekundách
     */
    final int fallSpeed;

    Difficulty(String description, int scoreCoeficient, int fallSpeed) {
        this.description = description;
        this.scoreCoeficient = scoreCoeficient;
        this.fallSpeed = fallSpeed;
    }

    /**
     * @return {@link #scoreCoeficient}
     */
    public int getScoreCoeficient() {
        return scoreCoeficient;
    }

    /**
     * Převede aktuální obtížnost na textovou reprezentaci pomocí jejího popisu.
     *
     * @return {@link #description}
     */
    @Override
    public String toString() {
        return description;
    }

    /**
     * @return {@link #fallSpeed}
     */
    public int getFallSpeed() {
        return fallSpeed;
    }
}
