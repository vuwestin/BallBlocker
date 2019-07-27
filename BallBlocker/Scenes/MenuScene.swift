//
//  MenuScene.swift
//  Tanks
//
//  Created by Westin Vu on 7/20/19.
//  Copyright © 2019 LearnAppMaking. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene{
    override func didMove(to view: SKView) {
        layoutScene()
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        let playLabel = SKLabelNode(text: "Tap to play!")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        
        let highScoreLabel = SKLabelNode(text:"Highscore: \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 25.0
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY/2)
        addChild(highScoreLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
