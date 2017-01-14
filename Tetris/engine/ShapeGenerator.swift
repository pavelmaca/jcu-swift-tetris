import Foundation

/**
 * Genrátor náhodných tvarů
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
class ShapeGenerator {
    
    /** Vygenerování náhodného čísla */
    private func getRandomInt(upperLimit:Int)->Int {
        return Int(arc4random_uniform(UInt32(upperLimit)))
    }

    /**
     * Vytvoření nové instance náhodného tvaru a jeho náhodného natočení a překlopení.
     *
     * @return Náhodně vybraný tvar
     */
    public func createNext()->Shape{
        let randomShape:Shape = getRandomShape()

        randomFlip(shape: randomShape)
        randomRotation(shape: randomShape)

        return randomShape
    }

    /**
     * Náhodný výběr tvyru ze seznamu typů
     *
     * @return Náhodně vybraný typ tvaru
     */
    private func getRandomShape()->Shape {
        let randomIndex = getRandomInt(upperLimit: ShapeType.allTypes.count)
        let randomType = ShapeType.allTypes[randomIndex];
        
        return ShapeDefinition.getDifinition(type: randomType)
    }

    /**
     * Náhodné otočení tvaru
     *
     * @param shape Otáčený tvar
     */
    private func randomRotation( shape:Shape)->Void {
        switch getRandomInt(upperLimit: 3) {
        // 0 - 3, pokud bude 3, tak se nepřeklopí, jinak číslo určuje (počet otočení - 1 )
            case 0:
                shape.rotate();
            case 1:
                shape.rotate();
            case 2:
                shape.rotate();
                break
            default:
                return
            
        }
    }

    /**
     * Náhodné překlopení tvaru
     *
     * @param shape Překlápěný tvar
     */
    private func randomFlip(shape:Shape) -> Void {
        switch getRandomInt(upperLimit: 2) { // 0 - 1, pokud bude 1, tak se nepřeklopí
            case 0:
                shape.flip();
                break;
            default:
                return
        }
    }

}
