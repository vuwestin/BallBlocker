//
//  GameViewController.swift
//  Tanks
//
//  Created by Westin Vu on 7/9/19.
//  Copyright © 2019 LearnAppMaking. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
           
            //might need to make this lazy
            let scene = MenuScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.size = view.bounds.size
                // Present the scene
            view.presentScene(scene)
            view.isMultipleTouchEnabled = true
            view.ignoresSiblingOrder = true
            //elements in our scene can be run in a nonfixed way
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
}
