package tetris.engine.board;

import java.io.Serializable;
import java.util.Date;

/**
 * Reprezentuje jeden záznam v žebříčku obsahující jméno hráče, datum hry a skóre
 * Uožnuje řazení podle skóre.
 * Pokud je skóre shodné, je řazeno podle data.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
public class Record implements Serializable, Comparable<Record> {
    /**
     * Jméno hráče
     */
    private String playerName;

    /**
     * Skóre
     */
    private int score;

    /**
     * Datum hry
     */
    private Date date;

    /**
     * @param playerName jméno hráče
     * @param score      skóre
     * @throws InvalidScoreException pokud je skóre záporné
     */
    Record(String playerName, int score) throws InvalidScoreException {
        if (score < 0) {
            throw new InvalidScoreException();
        }
        this.playerName = playerName;
        this.score = score;
        this.date = new Date();
    }

    /**
     * @return {@link #playerName}
     */
    public String getPlayerName() {
        return playerName;
    }

    /**
     * @return {@link #score}
     */
    public int getScore() {
        return score;
    }

    /**
     * @return {@link #date}
     */
    public Date getDate() {
        return date;
    }

    /**
     * Porovná aktální instnaci s instancí v parametru podle skóre
     * <p>
     * Vrátí 1 (větší) v přípdaě:
     * - aktuální skore je větší
     * - porovnávaný proměnná má hodnotu NULL
     * - skóre je shodné, ale aktuální datum je větší
     * <p>
     * Vrátí -1 (menší) v přípdaě:
     * - aktuální skore je menší
     * - skóre je shodné, ale aktuální datum je menší
     * <p>
     * Vrátí 0 (rovnost) v přípdaě:
     * - aktuální skore a datum jsou shodné s porovnávaným
     *
     * @param o porovnávaný záznam
     * @return
     */
    @Override
    public int compareTo(Record o) {
        if (o == null) {
            return 1;
        }
        int result = Integer.compare(o.getScore(), this.getScore());
        if (result == 0) {
            result = o.getDate().compareTo(this.getDate());
        }

        return result;
    }

    /**
     * Výjmka upozornující na naplenou hodnotu skóre
     */
    public class InvalidScoreException extends Exception {
    }
}
