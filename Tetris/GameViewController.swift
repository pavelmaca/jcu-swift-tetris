//
//  GameViewController.swift
//  Tetris
//
//  Created by pavel on 20/12/2016.
//  Copyright (c) 2016 pavel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var engine:Engine?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as! GameScene? {
                engine = scene.getEngine()
        
                scene.anchorPoint = CGPoint.zero
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                
                let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
                swipeLeft.direction = .left
                view.addGestureRecognizer(swipeLeft)
                
                let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
                swipeRight.direction = .right
                view.addGestureRecognizer(swipeRight)
                
                let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
                swipeDown.direction = .down
                view.addGestureRecognizer(swipeDown)
                
                // Present the scene
                view.presentScene(scene)
            }
        
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func handleSwipe(sender:UIGestureRecognizer){
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                engine!.moveLeft()
                break
            case UISwipeGestureRecognizerDirection.right:
                engine!.moveRight()
                break
            case UISwipeGestureRecognizerDirection.down:
                engine!.moveDown()
                break
            default:
                return
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        engine!.rotateShape()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
