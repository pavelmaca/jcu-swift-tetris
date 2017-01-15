import Foundation
import UIKit

/**
 * Objekt představující tvar v herní ploše.
 * Umožnuje otáčení a překlápění.
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
class Shape {

    /**
     * Body reprezentující tvar objektu v dvojrozměrném poli.
     * FALSE značí, že bod do objektu nepatří.
     */
    private var points:[[Bool]] = []

    /**
     * Barva tvaru
     */
    private var color:UIColor? = nil

    /**
     * @param points Body tvořící objekt v dvojrozměrném poli.
     * @param color  Barva objektu
     */
    init(points:[[Bool]], color:UIColor) {

        self.points = points
        self.color = color
    }

    /**
     * @return Výška objektu
     */
    public func getHeight()->Int {
        return points.count
    }

    /**
     * @return Šířka objektu
     */
    public func getWidth()->Int {
        return points.count > 0 ? points[0].count : 0
    }

    /**
     * @return Barva objektu
     */
    public func getColor()->UIColor? {
        return color
    }

    /**
     * @return Dvojrozměrné pole představujicí tvar objektu pomocí logických hodnot
     */
    public func getPoints()->[[Bool]] {
        return points
    }


    /**
     * Otočí objekt po sěru hodinových ručiček o 90 stupnů
     */
    public func rotate() {
        let width:Int = getWidth()
        let height:Int = getHeight()

        // nové dvojrozměrné pole s opačnými rozměry
        var newShape:[[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: height), count: width)
        
        for i in 0...width-1 {
            for j in (0..<height).reversed() {
                newShape[i][height - j - 1] = points[j][i] // Rotace o +90 stupnů: Transpose + Reverse each row
            }
        }

        points = newShape
    }


    /**
     * Vertikální překlopení
     */
    public func flip() {
        let width:Int = getWidth()
        let height:Int = getHeight()

        // zaokrouhleno nahoru
        let widthStop:Int = width / 2;

        for y in 0...height-1 {
            for x in 0...widthStop-1 {
                let tmp:Bool = points[y][x]
                points[y][x] = points[y][width - 1 - x]
                points[y][width - 1 - x] = tmp
            }
        }
    }
}
