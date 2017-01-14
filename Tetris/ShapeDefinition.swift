//
//  ShapeDefinition.swift
//  Tetris
//
//  Created by pavel on 21/12/2016.
//  Copyright © 2016 pavel. All rights reserved.
//
import UIKit

class ShapeDefinition {
    public static func getDifinition(type: ShapeType) ->Shape{
        switch type {
        case .LINE: return Shape(points: [
            [false, false, false],
            [true, true, true],
            [false, false, false],
            ], color: UIColor.magenta)
            
        case .CORNER: return Shape(points: [
            [true, false],
            [true, true],
            ], color: UIColor.orange)
            
        case .T: return Shape(points: [
            [true, true, true],
            [false, true, false],
            ], color: UIColor.green)
            
        case .SQUARE: return Shape(points: [
            [true, true],
            [true, true],
            ], color: UIColor.red)
            
        case .N: return Shape(points: [
            [true, true, false],
            [false, true, true],
            ], color: UIColor.yellow)
            
        case .L: return Shape(points: [
            [true, true, true],
            [true, false, false],
            ], color: UIColor.blue)
        }
        
    }
    
}
