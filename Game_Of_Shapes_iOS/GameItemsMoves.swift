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
    private let background: SKSpriteNode
    private var horizontal_shapes: [Shape] = [Shape]()
    private let level: Int
    private var increment: CGPoint
    private var direction: String
    
    private var regionSize: CGSize
    private var horizontal_region: SKCropNode = SKCropNode()
    private var vertical_region: SKCropNode = SKCropNode()
    private var mask: SKSpriteNode

    
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
        self.increment = CGPoint()
        self.increment.x = 0.0138 * displaySize.width
        self.increment.y = 0.0075 * displaySize.height
        print(increment)
        
        self.direction = "NONE"
        
        
        regionSize = CGSize(width: 0.952 * displaySize.width, height: 0.0973 * displaySize.height)
        mask = SKSpriteNode(color: SKColor.white, size: regionSize)
        mask.anchorPoint = CGPoint(x: 0, y: 0)
        mask.position = CGPoint(x: 0.024 * displaySize.width, y: 0.426 * displaySize.height)
        horizontal_region.maskNode = mask
        horizontal_region.zPosition = 3
        
        
    }
    
    func addToScene(scene: GameSceneMoves) {
        scene.addChild(background)

        for shape in horizontal_shapes {
            print("Name", shape.name!)
            horizontal_region.addChild(shape.opacity)
            horizontal_region.addChild(shape)
        }
        
        scene.addChild(horizontal_region)
    }
    
    func move(to: String) {
        direction = to
        print("swiped " + to)
    }
    
    func update(_ currentTime: TimeInterval) {
        switch direction {
        case "up":
            moveUp()
            break
        case "down":
            moveDown()
            break
        case "right":
            moveRight()
            break
        case "left":
            moveLeft()
            break
        default:
            break
        }
        
    }
    
    func moveUp() {

    }
    
    func moveDown() {

    }
    
    func moveRight() {
        for shape in horizontal_shapes {
            if shape.animated < shape.animation {
                shape.position.x += increment.x
                shape.opacity.position.x += increment.x
                shape.animated += increment.x
            }
            else {
                direction = "NONE"
                shape.animated = 0
            }
        }
    }
    
    func moveLeft() {

    }
}
