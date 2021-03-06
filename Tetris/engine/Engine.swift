import Foundation
import UIKit

/**
 * Logická implementace aplikace.
 * Řeší pohyby tvarů, stav hry a nastavení
 *
 * @author Pavel Máca <maca.pavel@gmail.com>
 */
class Engine {

    /* Uložiště uchovávající nepohyblivé objekty */
    private var storage:FieldStorage

    /* Další tvar v pořadí */
    private var nextShape:Shape?

    /* Aktuální pohyblivý tvar na kterém se provádějí akce */
    private var actualShape:Shape?

    /* Pozice aktuálního tvaru na ose X */
    private var actualX :Int = 0

    /* Pozice aktuálního tvaru na ose Y */
    private var actualY:Int = 0

    /* Stav určujicí zda hra běží */
    private var running:Bool = false

    /* Nastavná uroveň obtížnosti */
    private var  difficulty:Difficulty = Difficulty.MEDIUM

    /* Aktuální skóre */
    private var score:Int = 0

    /* Pole listenerů reagující na změnu stavu hry */
    private var gameStatusListeners:[(_:EventType)->Void] = [(evetn:EventType)->Void]()

    /* Generátor náhodných tvarů */
    private var generator:ShapeGenerator = ShapeGenerator()

    /**
     * Inicializace hry
     *
     * @param rowsCount počet řádků herního pole
     * @param colsCount počet soupců herního pole
     */
    public init(rowsCount:Int, colsCount:Int) {
        storage = FieldStorage(rowsCount: rowsCount, colsCount: colsCount)

        nextShape = generator.createNext()
        creteNewShape()
    }


    /**
     * Změní stav předchozího tvaru na aktuální a vytvoří nový následujicí.
     * Předchozí tvar má výchozí souřadnice na horním okraji uprostřed herní plochy.
     */
    private func creteNewShape() {
        actualShape = nextShape;
        actualX = storage.getColsCount() / 2 - actualShape!.getWidth() / 2;
        actualY = 0;

        nextShape = generator.createNext();
        /*for listener in gameStatusListeners{
            listener.shapeChange()
        }*/
    }

    /**
     * Pohyb aktuálního objektu a kotrola dopadu.
     * Při dopadu se promazávají plné řádky.
     * Počet promazaných řádků se násobý kooficientem podle obtížnosti a přičítá se do skóre
     * <p>
     * Pokud dojde ke kolizi po  dopadu a nastavení nového aktuálního objektu, hra končí.
     * <p>
     * Při odmazání řádku je vyvolán event typu {@link GameStatusListener.scoreChange()}.
     * Konec hry vyvolá událost typu {@link GameStatusListener.gameEnd()}.
     */
    public func tick() {
        if running && !moveDown() {
            storage.saveShape(shape: actualShape!, xPosition: actualX, yPosition: actualY);
            let removedCount:Int = storage.removeFullRows();
            if (removedCount > 0) {
                score += removedCount * storage.getColsCount() * (DifficultyList.list[difficulty]?.getScoreCoeficient())!;
                performScoreChangeEvent();
            }

            creteNewShape();
            if (storage.isCollision(shape: actualShape!, xPosition: actualX, yPosition: actualY)) {
                running = false;
                performGameEndEvent();
            }
        }
    }

    /**
     * Vytvoří dvojrozměrné pole barev, představující aktuální stav hry.
     *
     * @return dvojrozměrné pole barev, představující aktuální stav hry.
     */
    public func getStatus()->[[UIColor?]] {
        return storage.printStatus(shape: actualShape, xPosition: actualX, yPosition: actualY);
    }

    /**
     * Kontrola, zda je možné provést pohyb na dané souřadnice
     *
     * @param nextX pozice na ose X
     * @param nextY pozice na ose Y
     * @return true, pokud je možné aktuální tvar posunout na dané souřadnice
     */
    private func tryMove(nextX:Int, nextY:Int)->Bool {
        return running && !storage.isCollision(shape: actualShape!, xPosition: nextX, yPosition: nextY);
    }

    /*
     * Pohyb v levo, pokud je možný
     */
    public func moveLeft() {
        let nextX:Int = actualX - 1;
        if tryMove(nextX: nextX, nextY: actualY) {
            actualX = nextX;
        }
    }

    /**
     * Pohyb v pravo, pokud je možný
     */
    public func moveRight() {
        let nextX:Int = actualX + 1
        if tryMove(nextX: nextX, nextY: actualY) {
            actualX = nextX;
        }
    }

    /**
     * Pohyb dolů, pokud je možný
     *
     * @return true, pokud byl proveden pohyb
     */
    public func moveDown()->Bool {
        let nextY:Int = actualY + 1
        if tryMove(nextX: actualX, nextY: nextY) {
            actualY = nextY
            return true;
        }
        return false;
    }

    /**
     * Otočení aktuálního tvaru
     * Otočený tvar je vycentrován relativně k původní pozici,
     * případně posunut, aby nepřetékal herní plochu.
     * <p>
     * Pokud dojde ke kolizi je objekt vrácen do původní pozice a rotace se neguje.
     */
    public func rotateShape() {
        if !running {
            return;
        }

        let prevWidth:Int = actualShape!.getWidth()
        var newX:Int = actualX

        actualShape!.rotate()


        if (prevWidth != actualShape!.getWidth()) {
            newX += (prevWidth - actualShape!.getWidth()) / 2
        }

        // vycentrování - oprava pozice na x, po otočení na straně herní plochy
        if newX < 0 {
            newX = 0
        } else if (newX + actualShape!.getWidth() > storage.getColsCount()) {
            newX = storage.getColsCount() - actualShape!.getWidth()
        }

        // kontrola kolize po otočení a vycentrování
        if storage.isCollision(shape: actualShape!, xPosition: newX, yPosition: actualY) {
            // rotace zpět do původní polohy
            actualShape?.rotate()
            actualShape?.rotate()
            actualShape?.rotate()
        } else {
            actualX = newX
        }
    }

    /**
     * @return Počet řádků herní plochy
     */
    public func getRowsCount()->Int {
        return storage.getRowsCount();
    }

    /**
     * @return Počet sloupců herní plochy
     */
    public func getColsCount()->Int {
        return storage.getColsCount();
    }

    /**
     * Nastaví stav hry na "běží"
     */
    public func start() {
        running = true;
    }

    /**
     * Nastaví stav hry na "pozastaveno"
     */
    public func pause() {
        running = false;
    }

    /**
     * Zaregistruje listener, poslouchající události hry
     *
     * @param listener Listener implemetující rozhrani {@link GameStatusListener}
     */
    public func addGameStatusListener(listener:@escaping (_:EventType)->Void ) {
        gameStatusListeners.append(listener)
    }
    

    /**
     * Provedení všech akcí vazaných na změnu skóre v registrovaných listenerech
     */
    private func performScoreChangeEvent() {
       /* for listener in gameStatusListeners {
            listener.scoreChange(score: score)
        }*/
    }

    /**
     * Provedení všech akcí vazaných na konec hry v registrovaných listenerech
     */
    private func performGameEndEvent() {
        for listener in gameStatusListeners {
           // listener.gameEnd()
            listener(EventType.GAME_OVER)
        }
    }

    /**
     * @return Tvar, který bude následovat po katuálním
     */
    public func getNextShape()->Shape {
        return nextShape!;
    }

    /**
     * @return Aktuální skóre
     */
    public func getScore()->Int{
        return score;
    }

    /**
     * Pozastaví hru a vyresetuje její stav.
     * Nuluje skóre, uložiště a generuje nové tvary.
     * Vyvolává událost změna skóre
     */
    public func restart() {
        pause();

        score = 0;
        storage.resetStorage();
        nextShape = generator.createNext();
        creteNewShape();
        performScoreChangeEvent();
    }

    /**
     * @return {@link #difficulty}
     */
    public func getDifficulty()->Difficulty {
        return difficulty;
    }

    /**
     * Natavení obtížnosti hry
     *
     * @param difficulty nastavovaná obtížnost
     */
    public func setDifficulty(difficulty:Difficulty) {
        self.difficulty = difficulty;
    }

    /**
     * Kontroluje,zda hra běží.
     *
     * @return true, pokud hra běží
     */
    public func isRunning()->Bool {
        return running;
    }
}
