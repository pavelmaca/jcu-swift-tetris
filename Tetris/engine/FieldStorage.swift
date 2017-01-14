import Foundation
import UIKit

/**
 * Uložiště uchovávající nepohyblivé objekty
 * jako jeden blok.
 * Představuje celou herní plochu.
 * Pohlcuje tvary a jejich souřadnice a uchovává je jako jeden blok.
 * Představuje celou herní plochu nepohyblivých objektů.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
class FieldStorage {

    /**
     * Uchovává aktuální polohu a tvar nepohyblivých objektů
     */
    private var fileds: [[UIColor?]]

    /**
     * Vytvoří nové uložiště s danou velikostí
     *
     * @param rowsCount počet řádek
     * @param colsCount počet sloupců
     */
    init(rowsCount:Int, colsCount:Int) {
        fileds = [[UIColor?]](repeating: [UIColor?](repeating: nil, count: colsCount), count: rowsCount)        
    }

    /**
     * @return počet řádků
     */
    public func getRowsCount()->Int {
        return fileds.count
    }

    /**
     * @return počet sloupců
     */
    public func getColsCount()->Int {
        return fileds.count > 0 ? fileds[0].count : 0
    }

    /**
     * Vyresetuje aktuální stav na prázdnou plochu
     */
    public func resetStorage()->Void{
        fileds = [[UIColor?]](repeating: [UIColor?](repeating: nil, count: getColsCount()), count: getRowsCount())
    }

    /**
     * Přidá tvar do aktuální paměti
     * Pokud je tvar, nebo jeho část umístěna mimo herní pole, tato část bude ztracena
     *
     * @param shape     ukládaný tvar
     * @param xPosition pozice ukládaného tvaru na ose X
     * @param yPosition pozice ukládaného tvaru na ose YY
     */
    public func saveShape(shape:Shape, xPosition:Int, yPosition:Int) {
        margeShapeIntoFields(fields: &fileds, Shape: shape, xPosition: xPosition, yPosition: yPosition)
    }

    /**
     * Odebere všechny plné řádky a vrátí počet řádků, které byli odebrány.
     * Každý řádek nad odebíraným je posunut směrem dolů a je tak reprezentovat jejich "pád".
     *
     * @return počet odebraných řádek
     */
    public func removeFullRows()->Int {
        var count:Int = 0 // počet odebraných řádek

        let rowsCount:Int = getRowsCount()
        let colsCount:Int = getColsCount()

        var cleanedFilds:[[UIColor?]] = [[UIColor?]](repeating: [UIColor?](repeating: nil, count: colsCount), count: rowsCount) // nové pole bez odebraných řádků

        var n:Int = rowsCount - 1; // aktuální řádek, kam ukládá v novém poli

        for y in n...0 {
            var fullRow:Bool = true;
            for x in 0...colsCount-1 {
                if fileds[y][x] == nil {
                    fullRow = false
                    break
                }
            }
            if (!fullRow) {
                cleanedFilds[n] = fileds[y]
                n -= 1
            } else {
                count += 1
            }
        }

        fileds = cleanedFilds;
        return count;
    }


    /**
     * Kontrola, zda předaný tvar a jeho souřadnice jsou v kolizi s pevnou částí uložiště.
     * Zárovneň kontroluj, zda je tvar celý uvnitř rozměrů pro uložiště.
     *
     * @param shape     tvar ke kontrole
     * @param xPosition pozice na ose X, kontrolovaného tvaru
     * @param yPosition pozice na ose Y, kontrolovaného tvaru
     * @return true, pokud nastala kolize
     */
    public func isCollision(shape:Shape, xPosition:Int, yPosition:Int)->Bool {
        var points:[[Bool]] = shape.getPoints();

        let rowsCount:Int = getRowsCount()
        let colsCount:Int = getColsCount()

        for x in 0...shape.getWidth()-1 {
            for y in 0...shape.getHeight()-1 {
                if !points[y][x] {
                    continue
                }

                // kontrola přetečení okraje: postraní, spodní a horní
                if xPosition + x >= colsCount || xPosition + x < 0 || yPosition + y >= rowsCount || yPosition + y < 0 {
                    return true
                }

                // kolize s pevným blokem
                if fileds[yPosition + y][xPosition + x] != nil {
                    return true
                }
            }
        }

        return false
    }

    /**
     * Spojí body z tvaru do předaného pole barev reprezentující statický blok
     * Pokud je nějkaý bod mimo velikost statického bloku, bude skryt
     *
     * @param fields    pole barev, reprezentující statický tvar, do které se připojuje
     * @param shape     tvar k připojení
     * @param xPosition pozice na ose X pro tvar
     * @param yPosition pozice na ose Y pro tvar
     * @return vstupní pole modifikované o přidaný tvar
     */
    private func margeShapeIntoFields(fields:inout [[UIColor?]], Shape shape:Shape, xPosition:Int, yPosition:Int)->[[UIColor?]]{

        var points:[[Bool]] = shape.getPoints();

        for y in 0...points.count-1 {
            for x in 0...points[y].count-1 {
                let yAbs:Int = yPosition + y;
                let xAbs:Int = xPosition + x;
                if points[y][x] && xAbs >= 0 && xAbs < getColsCount() && yAbs >= 0 && yAbs < getRowsCount() {
                    fields[yPosition + y][xPosition + x] = shape.getColor();
                }
            }
        }

        return fields;
    }

    /**
     * Vytvoří dvojrozměrné pole reprezentujicí aktuální stav spojený s pohyblivým tvarem.
     * Nijak nemění vtniřní stav uložiště
     *
     * @param shape     pohyblivý tvar
     * @param xPosition pozice pohyblivého tvaru na ose X
     * @param yPosition pozice pohyblivého tvaru na ose Y
     * @return
     */
    public func printStatus(shape:Shape?, xPosition:Int, yPosition:Int)->[[UIColor?]] {
        var copyFields:[[UIColor?]] = deepCopyOfFileds(fieldsToCopy: fileds)!;
        if (shape == nil) {
            return copyFields;
        }
        return margeShapeIntoFields(fields: &copyFields, Shape: shape!, xPosition: xPosition, yPosition: yPosition);
    }

    /**
     * Vytvoří hlubokou kopii předaného dvojrozměrného pole barev
     *
     * @param fieldsToCopy kopírované dvojrozměrné pole barev
     * @return dvojrozměrná hluboká kopie předanéhp pole na vstupu
     */
    private func deepCopyOfFileds(fieldsToCopy:[[UIColor?]])->[[UIColor?]]? {
        return fieldsToCopy
        /*
        if fieldsToCopy.count == 0 {
            return nil
        }
        
    */
       /* var result:[[UIColor?]] = [UIColor?](repeating: [UIColor?](repeating: nil, count: fieldsToCopy[0].count), count: fieldsToCopy.count)
        for r in 0...fieldsToCopy.count {
            result[r] = fieldsToCopy[r].copy()
        }
        
      return result;*/
    }
}
