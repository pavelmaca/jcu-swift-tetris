import Foundation

/**
 * Seznam obtížností
 * jednotlivé obtížnosti obsahují koeficient obtížnosti, použitý pro výpočet skóre a textvoí popis.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public enum Difficulty {
    case EASY
    case MEDIUM
    case HARD
   
    /*
    EASY("Lehká", 1, 350),
    MEDIUM("Střední", 2, 250),
    HARD("Těžká", 3, 200);*/
    
}

class DifficultyList {
    static let list:[Difficulty: DifficultyObj] = [
        .EASY :DifficultyObj(description: "Lehká", scoreCoeficient: 1, fallSpeed: 350),
        .MEDIUM :DifficultyObj(description: "Střední", scoreCoeficient: 2, fallSpeed: 250),
        .HARD :DifficultyObj(description: "Těžká", scoreCoeficient: 3, fallSpeed: 200),
    ]
}

class DifficultyObj {
    /**
     * Popis obtížnosti
     */
    let description:String;

    /**
     * Koeficient obtížnosti
     */
    let scoreCoeficient:Int;

    /**
     * Rychlost pádu (prodleva mezi pohyby objektů) v milisekundách
     */
    let fallSpeed:Int;

    init(description:String, scoreCoeficient:Int, fallSpeed:Int) {
        self.description = description;
        self.scoreCoeficient = scoreCoeficient;
        self.fallSpeed = fallSpeed;
    }

    /**
     * @return {@link #scoreCoeficient}
     */
    public func getScoreCoeficient()->Int {
        return scoreCoeficient;
    }

    /**
     * Převede aktuální obtížnost na textovou reprezentaci pomocí jejího popisu.
     *
     * @return {@link #description}
     */
    public func toString()->String {
        return description;
    }

    /**
     * @return {@link #fallSpeed}
     */
    public func getFallSpeed()->Int {
        return fallSpeed;
    }
}
