//
//  StartViewController.swift
//  Tetris
//
//  Created by pavel on 15/01/2017.
//  Copyright © 2017 pavel. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit
class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleBtnPress(_ sender: Any) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as? GameViewController

        //self.performSegue(withIdentifier: "GameView", sender: self)
        self.navigationController!.pushViewController(mapViewControllerObj, animated: true)
    }
     override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
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
