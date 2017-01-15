//
//  GameScene.swift
//  Tetris
//
//  Created by pavel on 20/12/2016.
//  Copyright (c) 2016 pavel. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation


class GameScene: SKScene {

    private var label : SKLabelNode?
  //  private var spinnyNode : SKShapeNode?
    

    private var timer: Int = 0
    private let FPS = 60
    private var sceneWidth : Int = 0

    private var shapes: [[SKShapeNode]]?
    
    private var engine:Engine?
    
 /*   init(fileNamed:String){
        super.init(fileNamed: fileNamed)!
    }*/
    
    override init(size: CGSize){
        super.init(size: size)
        startup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        label?.isHidden = true
        
        startup()
    }
    

    func startup(){
        self.backgroundColor = .black
        
        let size = Int(self.size.width.divided(by: 10))
        let rows = Int(self.size.height.divided(by: CGFloat(size)))
        
        engine = Engine(rowsCount: rows , colsCount: 10)
        
        engine!.setDifficulty(difficulty: .MEDIUM)
        engine!.start()
       // let shape = SKShapeNode.init(rectOf: CGSize.init(width:20, height: 20), cornerRadius: 1)

    }
    
    func getEngine()->Engine{
        return engine!
    }
    
    override func update(_ currentTime: TimeInterval) {
        timer += 1
        if timer >= DifficultyList.list[engine!.getDifficulty()]!.getFallSpeed() * FPS / 1000 {
            engine!.tick()
            timer = 0
            makeMove()
        }
        /*if timer > 60 {
            makeMove()
        }*/
        // Called before each frame is rendered
    }
    
    func makeMove(){
        self.removeAllChildren()
        renderSquers()
        
    }
    
    func renderSquers(){
        let fields:[[UIColor?]] = engine!.getStatus()
        let squereSize:CGFloat = self.size.width.divided(by: CGFloat(engine!.getColsCount()))
        

        let yStart:CGFloat = self.size.height
        
        for x in 0...engine!.getColsCount()-1{
            for y in 0...engine!.getRowsCount()-1{
                var color = fields[y][x]
                
                if color == nil {
                    color = UIColor.white
                    continue
                }

                let shape = drawShape(color: color!,
                                      x: squereSize.multiplied(by: CGFloat(x)),
                                      y: yStart.adding(squereSize.multiplied(by: CGFloat(y+1)).negated()),
                                      size: squereSize)
                
                shapes?[y][x] = shape
                self.addChild(shape)
            }
        }

    }
    
    private func drawShape(color:UIColor, x:CGFloat, y:CGFloat, size:CGFloat)->SKShapeNode{
        let rect = CGRect(x: x, y: y, width: size, height: size)
        let shape = SKShapeNode.init(rect: rect)
        
        shape.fillColor = color
        shape.strokeColor = .lightGray
        shape.lineWidth = 3
        shape.glowWidth = 1
        
        //shape.fillTexture = SKTexture.init(image: UIImage(named: "shapePattern")!)
        
        // shape has position on bottom left corner
        //shape.position = CGPoint(x: squereSize.multiplied(by: CGFloat(x)), y: yStart - y * squereSize - squereSize)
        return shape
    }
    
    /*
    override func didMove(to view: SKView) {


        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    

    func touchDown(atPoint pos : CGPoint) {
        self.shape = SKShapeNode.init(rectOf: CGSize.init(width:10, height: 10), cornerRadius: 1)
        self.addChild(self.shape!)
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
        
        engine?.rotateShape()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    */

  /*  override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }*/
}
