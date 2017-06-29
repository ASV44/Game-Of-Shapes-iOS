//
//  GameItemsMoves.swift
//  Game_Of_Shapes_iOS
//
//  Created by Hackintosh on 6/29/17.
//  Copyright © 2017 Hackintosh. All rights reserved.
//

import Foundation
import SpriteKit

class GameItemsMoves {
    let background: SKSpriteNode
    var horizontal_shapes: [Shape] = [Shape]()
    private let level: Int
    
    init(gameMode: String, level: Int) {
        let displaySize: CGRect = UIScreen.main.bounds
        print(displaySize.width)
        print(displaySize.height)
        
        background = SKSpriteNode(imageNamed: "background.png")
        background.size = CGSize(width: displaySize.width, height: displaySize.height)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        horizontal_shapes.append(Shape(orientation: "horizontal", location: 1, shapeName: "13_30.png"))
        
        self.level = level + 5
    }
    
    func update(_ currentTime: TimeInterval) {
        
    }
    
    func moveUp() {
        print("swiped up")
    }
    
    func moveDown() {
        print("swiped down")
    }
    
    func moveRight() {
        print("swiped right")
    }
    
    func moveLeft() {
        print("swiped left")
    }
}
