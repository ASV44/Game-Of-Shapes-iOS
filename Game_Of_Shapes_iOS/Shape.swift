//
//  Shape.swift
//  Game_Of_Shapes_iOS
//
//  Created by Hackintosh on 6/5/17.
//  Copyright © 2017 Hackintosh. All rights reserved.
//

import Foundation
import SpriteKit

class Shape: SKSpriteNode {
    let width: CGFloat
    let height: CGFloat
    var location: Int
    var animated: CGFloat
    var animation: CGFloat
    let id: Int
    let connect: String
    let opacity: SKSpriteNode
    let cloned: Bool
    enum shapeOrientation: String {case NONE, HORIZONTAL, VERTICAL, PIVOT}
    var orientation: shapeOrientation

    init(orientation: shapeOrientation, location: Int, shapeName: String) {
        let texture = SKTexture(imageNamed: shapeName)
        let displaySize: CGRect = UIScreen.main.bounds
        width = 0.1694 * displaySize.width
        height = 0.0973 * displaySize.height
        self.location = location
        animated = 0
        switch orientation {
        case .VERTICAL:
            animation = 0.1077 * displaySize.height
            break
        case .HORIZONTAL:
            animation = 0.1925 * displaySize.width
            break
        default:
            animation = 0
            break
        }
        let startIndex = shapeName.characters.distance(from: shapeName.startIndex, to: shapeName.characters.index(of: "_")!)
        var start = shapeName.index(shapeName.startIndex, offsetBy: startIndex)
        id = Int(shapeName.substring(to: start))!
        start = shapeName.index(shapeName.startIndex, offsetBy: startIndex + 1)
        let endIndex = shapeName.characters.distance(from: shapeName.startIndex, to: shapeName.characters.index(of: ".")!)
        let end = shapeName.index(shapeName.startIndex, offsetBy: endIndex)
        let range = start..<end
        connect = shapeName.substring(with: range)
//        print("Id",id)
//        print("Connect",connect)
        opacity = SKSpriteNode(imageNamed: "opacity")
        cloned = false
        self.orientation = orientation
        if(location == 2) {
            self.orientation = .PIVOT
        }
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        anchorPoint = CGPoint(x: 0, y: 0)
        name = shapeName
        switch orientation {
        case .VERTICAL:
            position.x = 0.413 * displaySize.width
            let gap = CGFloat(location) * CGFloat(0.0104) * displaySize.height
            position.y = 0.210 *  displaySize.height + CGFloat(location) * CGFloat(height) + gap
            break
        case .HORIZONTAL:
            let gap = CGFloat(location) * CGFloat(0.0221) * displaySize.width
            position.x = 0.0304 * displaySize.width + CGFloat(location) * CGFloat(width) + gap
            position.y = 0.426 * displaySize.height
            break
        default:
            break
        }
        size = CGSize(width: width, height: height)
        opacity.size = CGSize(width: width, height: height)
        opacity.anchorPoint = CGPoint(x: 0, y: 0)
        opacity.zPosition = -1
        self.addChild(self.opacity)
        zPosition = 2
    }
    
    init(shape: Shape) {
        width = shape.width
        height = shape.height
        self.location = shape.location
        animated = 0
        animation = shape.animation
        id = shape.id
        connect = shape.connect
        opacity = SKSpriteNode(imageNamed: "opacity")
        cloned = true
        orientation = shape.orientation
        super.init(texture: shape.texture, color: UIColor.clear, size: (shape.texture?.size())!)
        anchorPoint = CGPoint(x: 0, y: 0)
        name = shape.name
        position = shape.position
        size = CGSize(width: width, height: height)
        opacity.size = CGSize(width: width, height: height)
        opacity.anchorPoint = CGPoint(x: 0, y: 0)
        opacity.zPosition = -1
        self.addChild(self.opacity)
        zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCoordinates(orientation: GameItemsMoves.moveDirection) {
        let displaySize: CGRect = UIScreen.main.bounds
        
        switch orientation {
        case .VERTICAL:
            position.x = 0.413 * displaySize.width
            let gap = CGFloat(location) * CGFloat(0.0104) * displaySize.height
            position.y = 0.210 *  displaySize.height + CGFloat(location) * CGFloat(height) + gap
            animation = 0.1077 * displaySize.height
            break
        case .HORIZONTAL:
            let gap = CGFloat(location) * CGFloat(0.0221) * displaySize.width
            position.x = 0.0304 * displaySize.width + CGFloat(location) * CGFloat(width) + gap
            position.y = 0.426 * displaySize.height
            animation = 0.1925 * displaySize.width
            break
        default:
            break
        }
    }
    
    func move(direction: GameItemsMoves.moveDirection ,increment: CGPoint) {
        switch direction {
        case .UP:
            position.y += increment.y
            animated += increment.y
            break
        case .DOWN:
            position.y -= increment.y
            animated += increment.y
            break
        case .RIGHT:
            position.x += increment.x
            animated += increment.x
            break
        case .LEFT:
            position.x -= increment.x
            animated += increment.x
            break
        default:
            break
        }

        
    }
    
    func increaseLocation(orientation: GameItemsMoves.moveDirection) {
        print("animation",animation)
        print("animated",animated)
        animated = 0
        location += 1
        checkPivot(orientation: changeConstant(constant: orientation))
        updateCoordinates(orientation: orientation)
    }
    
    func decreaseLocation(orientation: GameItemsMoves.moveDirection, bound: Int) {
        print("animation",animation)
        print("animated",animated)
        animated = 0
        location -= 1
        if location < 0 {
            location = bound - 1
        }
        checkPivot(orientation: changeConstant(constant: orientation))
        updateCoordinates(orientation: orientation)
    }
    
    func changeLocation(direction: GameItemsMoves.Direction, bound: Int) {
        if(direction.moveDirection == .UP || direction.moveDirection == .RIGHT) {
            increaseLocation(orientation: direction.orientation)
        }
        else {
            decreaseLocation(orientation: direction.orientation, bound: bound)
        }
    }
    
    func checkPivot(orientation: shapeOrientation) {
        if(location == 2) {
            self.orientation = .PIVOT
        }
        else if self.orientation == .PIVOT {
            self.orientation = orientation
        }
    }
    
    func changeConstant(constant: GameItemsMoves.moveDirection) -> shapeOrientation {
        var newConstant: shapeOrientation = .NONE
        switch constant {
        case GameItemsMoves.moveDirection.HORIZONTAL:
            newConstant = .HORIZONTAL
            break
        case GameItemsMoves.moveDirection.VERTICAL:
            newConstant = .VERTICAL
            break
        default:
            break
        }
        
        return newConstant
    }
}
