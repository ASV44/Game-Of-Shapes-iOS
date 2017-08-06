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
    private var vertical_shapes: [Shape] = [Shape]()
    private let level: Int
    private var increment: CGPoint
    enum moveDirection { case NONE,UP, DOWN, RIGHT, LEFT, HORIZONTAL, VERTICAL}
    private var direction: moveDirection
    
    private var regionSize: CGSize
    private var horizontal_region: SKCropNode = SKCropNode()
    private var vertical_region: SKCropNode = SKCropNode()
    private var mask: SKSpriteNode
    
    init(gameMode: String, level: Int) {
        let displaySize: CGRect = UIScreen.main.coordinateSpace.bounds
        print(displaySize.width)
        print(displaySize.height)
        
        background = SKSpriteNode(imageNamed: "background.png")
        background.size = CGSize(width: displaySize.width, height: displaySize.height)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        horizontal_shapes.append(Shape(orientation: "horizontal", location: 1, shapeName: "13_30.png"))
        
        vertical_shapes.append(Shape(orientation: "vertical", location: 1, shapeName: "13_10.png"))
        
        self.level = level + 5
        self.increment = CGPoint()
        self.increment.x = 0.0138 * displaySize.width
        self.increment.y = 0.0075 * displaySize.height
        print(increment)
        
        self.direction = .NONE
        
        
        regionSize = CGSize(width: 0.952 * displaySize.width, height: 0.0973 * displaySize.height)
        mask = SKSpriteNode(color: SKColor.white, size: regionSize)
        mask.anchorPoint = CGPoint(x: 0, y: 0)
        mask.position = CGPoint(x: 0.024 * displaySize.width, y: 0.426 * displaySize.height)
        horizontal_region.maskNode = mask
        horizontal_region.zPosition = 3
        
        regionSize = CGSize(width: 0.1916 * displaySize.width, height: 0.5369 * displaySize.height)
        mask = SKSpriteNode(color: SKColor.white, size: regionSize)
        mask.anchorPoint = CGPoint(x: 0, y: 0)
        mask.position = CGPoint(x: 0.3981 * displaySize.width, y: 0.2052 * displaySize.height)
        vertical_region.maskNode = mask
        vertical_region.zPosition = 3
        
    }
    
    func addToScene(scene: GameSceneMoves) {
        scene.addChild(background)

        for shape in horizontal_shapes {
            print("Name", shape.name!)
            horizontal_region.addChild(shape.opacity)
            horizontal_region.addChild(shape)
        }
        
        for shape in vertical_shapes {
            print("Name", shape.name!)
            vertical_region.addChild(shape.opacity)
            vertical_region.addChild(shape)
        }
        
        scene.addChild(horizontal_region)
        scene.addChild(vertical_region)
    }
    
    func move(to: moveDirection) {
        
        direction = to
        switch direction {
        case .UP:
            let bound = getMoveBound(moveDirection: .VERTICAL)
            if bound == 5 {
                cloneShape(shapes_vector: &vertical_shapes, direction: .VERTICAL, location: bound - 1)
            }
            else {
                vertical_shapes[bound - 1].location = -1
                vertical_shapes[bound - 1].updateCoordinates(orientation: .VERTICAL)
            }
            break
        case .DOWN:
            let bound = getMoveBound(moveDirection: .VERTICAL)
            if bound == 5 {
                cloneShape(shapes_vector: &vertical_shapes, direction: .VERTICAL, location: 0)
            }
            break
        case .RIGHT:
            let bound = getMoveBound(moveDirection: .HORIZONTAL)
            if bound == 5 {
                cloneShape(shapes_vector: &horizontal_shapes, direction: .HORIZONTAL, location: bound - 1)
            }
            else {
                horizontal_shapes[bound - 1].location = -1
                horizontal_shapes[bound - 1].updateCoordinates(orientation: .HORIZONTAL)
            }
            break
        case .LEFT:
            let bound = getMoveBound(moveDirection: .HORIZONTAL)
            if bound == 5 {
                cloneShape(shapes_vector: &horizontal_shapes, direction: .HORIZONTAL, location: 0)
            }
            break
        default:
            break
        }
        print("swiped",to)
    }
    
    func update(_ currentTime: TimeInterval) {
        switch direction {
        case .UP:
            moveShapes(shapes_vector: &vertical_shapes, direction: .UP, orientation: .VERTICAL)
            break
        case .DOWN:
            moveShapes(shapes_vector: &vertical_shapes, direction: .DOWN, orientation: .VERTICAL)
            break
        case .RIGHT:
            moveShapes(shapes_vector: &horizontal_shapes, direction: .RIGHT, orientation: .HORIZONTAL)
            break
        case .LEFT:
            moveShapes(shapes_vector: &horizontal_shapes, direction: .LEFT, orientation: .HORIZONTAL)
            break
        default:
            break
        }
        
    }
    
    func moveShapes(shapes_vector: inout [Shape], direction: moveDirection, orientation: moveDirection) {
        for shape in shapes_vector {
            if shape.animated < shape.animation {
                shape.move(direction: direction, increment: increment)
            }
            else {
                if self.direction != .NONE {
                    self.direction = .NONE
                }
                if(shape.cloned) {
                    shapes_vector.remove(at: shapes_vector.index(of: shape)!)
                }
                if(direction == .UP || direction == .RIGHT) {
                    shape.increaseLocation(orientation: orientation)
                }
                else {
                    shape.decreaseLocation(orientation: orientation)
                }
            }
        }
    }
    
    private func getMoveBound(moveDirection: moveDirection)->Int {
        switch moveDirection {
        case .HORIZONTAL:
            if horizontal_shapes.count > 5 {
                return horizontal_shapes.count
            }
            break
        case .VERTICAL:
            if vertical_shapes.count > 5 {
                return vertical_shapes.count
            }
            break
        default:
            break;
        }
        
        return 5
    }
    
    func cloneShape(shapes_vector: inout [Shape], direction: moveDirection, location: Int) {
        let shapes_region: SKCropNode
        
        if direction == .HORIZONTAL {
            shapes_region = horizontal_region
        }
        else {
            shapes_region = vertical_region
        }
        let moveBound = getMoveBound(moveDirection: direction)
        for shape in shapes_vector {
            if shape.location == location {
                let newShape = Shape(shape: shape)
                shapes_vector.append(newShape)
                shapes_region.addChild(newShape.opacity)
                shapes_region.addChild(newShape)
                if location == 0 {
                    shape.location = moveBound
                }
                else {
                    shape.location = -1;
                }
                shape.updateCoordinates(orientation: direction)
            }
        }
    }
}
