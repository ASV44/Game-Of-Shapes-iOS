//
//  GameSceneMoves.swift
//  Game_Of_Shapes_iOS
//
//  Created by Hackintosh on 5/26/17.
//  Copyright © 2017 Hackintosh. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSceneMoves: SKScene {
    
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
//    private var horizontal_shapes: [Shape] = [Shape]()
    
    private var items : GameItemsMoves
    
    init(gameMode: String, level: Int) {
        let displaySize: CGRect = UIScreen.main.bounds
        print(displaySize.width)
        print(displaySize.height)
        let size = CGSize(width: displaySize.width, height: displaySize.height)
        items = GameItemsMoves(gameMode: gameMode, level: level)
        super.init(size: size)
        
        items.addToScene(scene: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        print("GameScene sceneDidLoad")
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
        
        self.items.update(currentTime)
        
    }
    
    override func didMove(to view: SKView) {
        print("GameScene didMoveTo")
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneMoves.swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneMoves.swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneMoves.swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameSceneMoves.swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    func swipedRight(_ sender:UISwipeGestureRecognizer){
        if(items.direction.moveDirection == GameItemsMoves.moveDirection.NONE) {
            items.move(to: GameItemsMoves.Direction(moveDirection: GameItemsMoves.moveDirection.RIGHT,
                                                    orientation: GameItemsMoves.moveDirection.HORIZONTAL))
        }
    }
    
    func swipedLeft(_ sender:UISwipeGestureRecognizer){
        if(items.direction.moveDirection == GameItemsMoves.moveDirection.NONE) {
            items.move(to: GameItemsMoves.Direction(moveDirection: GameItemsMoves.moveDirection.LEFT,
                                                    orientation: GameItemsMoves.moveDirection.HORIZONTAL))
        }
    }
    
    func swipedUp(_ sender:UISwipeGestureRecognizer){
        if(items.direction.moveDirection == GameItemsMoves.moveDirection.NONE) {
            items.move(to: GameItemsMoves.Direction(moveDirection: GameItemsMoves.moveDirection.UP,
                                                    orientation: GameItemsMoves.moveDirection.VERTICAL))
        }
    }
    
    func swipedDown(_ sender:UISwipeGestureRecognizer){
        if(items.direction.moveDirection == GameItemsMoves.moveDirection.NONE) {
            items.move(to: GameItemsMoves.Direction(moveDirection: GameItemsMoves.moveDirection.DOWN,
                                                    orientation: GameItemsMoves.moveDirection.VERTICAL))
        }
    }
}
