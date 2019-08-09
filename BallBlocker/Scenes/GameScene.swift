//
//  GameScene.swift
//  Tanks
//
//  Created by Westin Vu on 7/9/19.
//  Copyright © 2019 LearnAppMaking. All rights reserved.
//

import SpriteKit
//import Settings.swift

class GameScene: SKScene {
    
    var redBall: SKSpriteNode!
    var blueBall: SKSpriteNode!
//    var touch: UITouch?
//    private var activeTouches = [UITouch:String]()
    private var scoreLabel = SKLabelNode(fontNamed: "ArialMT")
    private var score: Int = 0
    {
        didSet{
            //scoreLabel.text = "Score: \(score)"
            scoreLabel.text = String(score)
        }
    }
    
    override func didMove(to view: SKView) {
        //print("\(self.frame)")
        //print("\(view.frame)")
        setupPhysics()
        layoutScene()
        layoutStarterBullets()
        labelSetup()
    }
    
    func labelSetup(){
        scoreLabel.color = SKColor.black
        scoreLabel.fontSize = 40
        scoreLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        //scoreLabel.text = "Score: \(score)"
        scoreLabel.text = String(score)
        scoreLabel.zPosition = ZPositions.scoreLabel
        addChild(scoreLabel)
        
        let wait = SKAction.wait(forDuration: 0.5)
        let addScore = SKAction.run {
            self.score += 1
        }
        let sequence = SKAction.repeatForever(SKAction.sequence([wait, addScore]))
        run(sequence)
    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene()
    {
        self.backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        redBall = SKSpriteNode(imageNamed: "redCircleGood")
        blueBall = SKSpriteNode(imageNamed: "blueCircleGood")
        
        
        redBall.size = CGSize(width: self.frame.size.width/20, height: self.frame.size.width/20)
        blueBall.size = CGSize(width: self.frame.size.width/20, height: self.frame.size.width/20)
        
        redBall.position = CGPoint(x: self.frame.minX + redBall.size.height, y: self.frame.midY)
        blueBall.position = CGPoint(x: self.frame.maxX - redBall.size.height, y: self.frame.midY)
        //change this later to align with landscape
        
        redBall.physicsBody = SKPhysicsBody(circleOfRadius: redBall.size.width/2)
        redBall.physicsBody?.categoryBitMask = PhysicsCategories.redBallCategory
        redBall.physicsBody?.collisionBitMask = PhysicsCategories.redBallCategory | PhysicsCategories.borderCategory
        redBall.zPosition = ZPositions.balls
        redBall.physicsBody?.allowsRotation = false
        
        blueBall.physicsBody = SKPhysicsBody(circleOfRadius: redBall.size.width/2)
        blueBall.physicsBody?.categoryBitMask = PhysicsCategories.blueBallCategory
        //tankTwo.physicsBody?.categoryBitMask = PhysicsCategories.tankOneCategory
        blueBall.physicsBody?.collisionBitMask = PhysicsCategories.redBallCategory | PhysicsCategories.borderCategory
        blueBall.zPosition = ZPositions.balls
        blueBall.physicsBody?.allowsRotation = false
        
        let scr = frame.size
//        let c = SKConstraint.positionX(SKRange(lowerLimit: 0.0 + redBall.size.width/2, upperLimit: scr.width - redBall.size.width/2), y: SKRange(lowerLimit: 0.0 + redBall.size.width/2, upperLimit: scr.height - redBall.size.width/2))
        //only closes off to center of circle
        //adjust to account for the rest of the circle
        
        //tankOne.constraints = [ c ]
        //tankTwo.constraints = [ c ]

        let dpadShape = SKShapeNode(circleOfRadius: 75)
        dpadShape.strokeColor = UIColor.white
        dpadShape.lineWidth = 2.0
        
        dpadShape.position.x = dpadShape.frame.size.width / 2 + 10
        dpadShape.position.y = dpadShape.frame.size.height / 2 + 10
        
        let otherDpadShape = SKShapeNode(circleOfRadius: 75)
        otherDpadShape.strokeColor = UIColor.white
        otherDpadShape.lineWidth = 2.0
        
        otherDpadShape.position.x = scr.width - (dpadShape.frame.size.width / 2 + 10)
        otherDpadShape.position.y = dpadShape.frame.size.height / 2 + 10
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.physicsBody = border
        //self.physicsBody?.categoryBitMask = PhysicsCategories.none //uncomment to make balls go off screen
        self.physicsBody?.collisionBitMask = PhysicsCategories.none
        self.physicsBody?.categoryBitMask = PhysicsCategories.borderCategory //uncomment to make balls go off screen
        
        self.addChild(redBall)
        self.addChild(blueBall)
        self.addChild(dpadShape)
        self.addChild(otherDpadShape)

//        spawnBullet(speedOf: CGVector(dx: 1000, dy: 200), at: CGPoint(x: 200, y: 50))
//        print(frame.size.height - tankOne.size.width)
//        print(tankOne.size.width)
//        print(frame.size.width - tankOne.size.width)
    }
    
    func spawnBullet(speedOf vel: CGVector, at point: CGPoint){ //add argument to check if tank one or tank two is firing
        let bullet = SKSpriteNode(imageNamed: "ball")
        bullet.name = "bullet"
        bullet.size = CGSize(width: self.frame.size.width/50, height: self.frame.size.width/50)
        bullet.position = point
        //change later
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
        bullet.physicsBody?.categoryBitMask = PhysicsCategories.bulletCategory
        //
        //bullet.physicsBody?.contactTestBitMask = PhysicsCategories.tankTwoCategory
        bullet.physicsBody?.contactTestBitMask = PhysicsCategories.redBallCategory | PhysicsCategories.borderCategory
        bullet.physicsBody?.collisionBitMask = PhysicsCategories.redBallCategory | PhysicsCategories.blueBallCategory | PhysicsCategories.bulletCategory
        //collides then disappears
        bullet.physicsBody?.linearDamping = 0
        bullet.physicsBody?.angularDamping = 0
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.restitution = 1
        bullet.physicsBody?.friction = 0
        bullet.zPosition = ZPositions.bullet
       
        self.addChild(bullet)
        bullet.physicsBody?.velocity = vel
    }
    
    func layoutStarterBullets(){
        var randomNum = Int(arc4random_uniform(500))
        spawnBullet(speedOf: CGVector(dx: randomNum,dy: 500-randomNum), at: CGPoint(x: 200, y: 50))
        randomNum = Int(arc4random_uniform(500))
        //spawnBullet(speedOf: CGVector(dx: 500,dy: 500), at: CGPoint(x: 400, y: 50))
        //spawnBullet(speedOf: CGVector(dx: -500,dy: 0), at: CGPoint(x: 600, y: 50))
        spawnBullet(speedOf: CGVector(dx: randomNum,dy: 500-randomNum), at: CGPoint(x: 300, y: 200))
        randomNum = Int(arc4random_uniform(500))
        spawnBullet(speedOf: CGVector(dx: randomNum,dy: 500-randomNum), at: CGPoint(x: 500, y: 200))
    }
    
    func gameOver()
    {
        if self.score > UserDefaults.standard.integer(forKey: "HighScore") {
            UserDefaults.standard.set(self.score, forKey: "HighScore")
        }
        let menuScene = MenuScene(size: self.view!.bounds.size)
        self.view!.presentScene(menuScene)
    }
    
    func virtualDPad() -> CGRect {
        var vDPad = CGRect(x: 0, y: 0, width: 150, height: 150)
        vDPad.origin.y = self.frame.size.height - vDPad.size.height - 10
        vDPad.origin.x = 10
        return vDPad
    }
    
    func otherVirtualDPad() -> CGRect {
        var vDPad = CGRect(x: frame.size.width - 150, y: 0, width: 150, height: 150)
        //CGRects originiall start with the origin at the upper left corner
        //skspritenodes start at the lower left corner
         vDPad.origin.y = self.frame.size.height - vDPad.size.height - 10
         vDPad.origin.x = self.frame.size.width - 160
        return vDPad
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if let touch = touch{
        for touch in touches{
            let touchLocation = touch.location(in: self.view)
            if virtualDPad().contains(touchLocation)
            {
                let velocityMultiplier: CGFloat = 4.0
                let middleOfCircleX = virtualDPad().origin.x + 75
                let middleOfCircleY = virtualDPad().origin.y + 75
                let lengthOfX = CGFloat(touchLocation.x - middleOfCircleX)
                let lengthOfY = CGFloat(touchLocation.y - middleOfCircleY) * -1
                redBall.physicsBody?.velocity = CGVector(dx: lengthOfX * velocityMultiplier,dy: lengthOfY * velocityMultiplier)
            }
            else if otherVirtualDPad().contains(touchLocation)
            {
                let velocityMultiplier: CGFloat = 4.0
                let middleOfCircleX = otherVirtualDPad().origin.x + 75
                let middleOfCircleY = otherVirtualDPad().origin.y + 75
                let lengthOfX = CGFloat(touchLocation.x - middleOfCircleX)
                let lengthOfY = CGFloat(touchLocation.y - middleOfCircleY) * -1
                blueBall.physicsBody?.velocity = CGVector(dx: lengthOfX * velocityMultiplier,dy: lengthOfY * velocityMultiplier)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        redBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        blueBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
}



extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody //bullet
        var secondBody: SKPhysicsBody //tank
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA //bullet
            secondBody = contact.bodyB //tank
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
//        if let unwrappedSecondBody = secondBody.node?.name{
//            if unwrappedSecondBody == "tankOne"{
//                print("tank one sucks")
//            }
//            else if unwrappedSecondBody == "tankTwo"{
//                print("tank two sucks")
//                //firstBody.applyImpulse(CGVector(dx: -100 , dy:0 ))
//                print(firstBody.node?.position)
//            }
     //   }
        if ((firstBody.categoryBitMask & PhysicsCategories.bulletCategory > 0) && (secondBody.categoryBitMask & PhysicsCategories.redBallCategory > 0))
        {
            gameOver()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategories.bulletCategory > 0) && //bullet hits border
            (secondBody.categoryBitMask & PhysicsCategories.borderCategory > 0)){
            //print("hello")
            if let xPos = firstBody.node?.position.x {
                if let yPos = firstBody.node?.position.y{
                    let bulletVelocity = firstBody.velocity
                    firstBody.node?.removeFromParent()
                    if ((yPos >= frame.size.height - redBall.size.width) && (xPos < redBall.size.width) )
                    {
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: frame.size.width - redBall.size.width/2, y: redBall.size.width/2))
                    }
                    else if ((yPos < redBall.size.width) && (xPos < redBall.size.width) )
                    {
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: frame.size.width - redBall.size.width/2, y: frame.size.height - redBall.size.width/2))
                    }
                    else if ((yPos >= frame.size.height - redBall.size.width) && (xPos >= frame.size.width - redBall.size.width))
                    {
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: redBall.size.width, y: redBall.size.width))
                    }
                    else if ((yPos < redBall.size.width) && (xPos >= frame.size.width - redBall.size.width))
                    {
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: redBall.size.width, y: frame.size.height - redBall.size.width))
                    }
                    else if (yPos >= frame.size.height - redBall.size.width){
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: xPos, y: redBall.size.width/2))
                    }
                    else if(yPos < redBall.size.width){
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: xPos, y:frame.size.height - redBall.size.width/2))
                    }
                    else if (xPos >= frame.size.width - redBall.size.width){
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: redBall.size.width/2, y: yPos))
                    }
                    else if(xPos < redBall.size.width){
                        spawnBullet(speedOf: bulletVelocity, at: CGPoint(x: frame.size.width - redBall.size.width/2, y:yPos))
                    }
                }
            }
        }
    }
    
}
