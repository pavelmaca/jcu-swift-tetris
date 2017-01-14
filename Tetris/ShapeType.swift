//
//  ShapeType.swift
//  Tetris
//
//  Created by pavel on 21/12/2016.
//  Copyright © 2016 pavel. All rights reserved.
//

/**
 * Seznam dostupných typů tvarů a jejich předpisy.
 * Každý typ má pevně nastavenou barvu a je definován dvourozměrným polem "bodů".
 */
enum ShapeType {
    case LINE
    case CORNER
    case T
    case SQUARE
    case N
    case L
    
    static let allTypes = [LINE, CORNER, T, SQUARE, N, L]
}


