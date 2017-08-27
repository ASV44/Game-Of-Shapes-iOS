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
    private var shapes: [Shape] = [Shape]()
    private let level: Int
    private var increment: CGPoint
    enum moveDirection: String { case NONE,UP, DOWN, RIGHT, LEFT, HORIZONTAL, VERTICAL}
    struct Direction {
        var moveDirection: moveDirection
        var orientation: moveDirection
    }
    var direction: Direction
    private var region: SKCropNode = SKCropNode()
    var shapesAmount: [moveDirection: Int]
    
    init(gameMode: String, level: Int) {
        let displaySize: CGRect = UIScreen.main.coordinateSpace.bounds
        print(displaySize.width)
        print(displaySize.height)
        
        background = SKSpriteNode(imageNamed: "background.png")
        background.size = CGSize(width: displaySize.width, height: displaySize.height)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        self.level = level + 5
        self.increment = CGPoint()
        self.increment.x = 0.0138 * displaySize.width
        self.increment.y = 0.0075 * displaySize.height
        print(increment)
        
        self.direction = Direction(moveDirection: .NONE, orientation: .NONE)
        
        var regionSize: CGSize = CGSize(width: 0.952 * displaySize.width, height: 0.0973 * displaySize.height)
        let mask: SKSpriteNode = SKSpriteNode(color: SKColor.white, size: regionSize)
        mask.anchorPoint = CGPoint(x: 0, y: 0)
        mask.position = CGPoint(x: 0.024 * displaySize.width, y: 0.426 * displaySize.height)

        
        regionSize = CGSize(width: 0.1916 * displaySize.width, height: 0.5369 * displaySize.height)
        let verticalMask = SKSpriteNode(color: SKColor.white, size: regionSize)
        verticalMask.position = CGPoint(x: mask.size.width / 2, y: mask.size.height / 2)
        mask.addChild(verticalMask)
        
        region.maskNode = mask
        region.zPosition = 3
        shapesAmount = [moveDirection: Int]()
        
        self.createShapes()
    }
    
    func createShapes() {
        shapes.append(Shape(orientation: Shape.shapeOrientation.HORIZONTAL, location: 1, shapeName: "13_30.png"))
        shapes.append(Shape(orientation: Shape.shapeOrientation.VERTICAL, location: 2, shapeName: "13_30.png"))
        shapes.append(Shape(orientation: Shape.shapeOrientation.VERTICAL, location: 1, shapeName: "13_10.png"))
        shapesAmount[.HORIZONTAL] = 2
        shapesAmount[.VERTICAL] = 2
        //        var middleShape = Shape(orientation: "horizontal", location: 2, shapeName: "13_30.png")
        //        horizontal_shapes.append(middleShape)
        //        vertical_shapes.append(middleShape)
    }
    
    func addToScene(scene: GameSceneMoves) {
        scene.addChild(background)

        for shape in shapes {
            print("Name", shape.name!)
            region.addChild(shape)
        }
        
        scene.addChild(region)
    }
    
    func move(to: Direction) {
        
        direction = to

        updateShapesByDirection(direction: to)
        
        print("swiped",to.moveDirection.rawValue)
    }
    
    func updateShapesByDirection(direction: Direction) {
        let bound = getMoveBound(moveDirection: direction.moveDirection)
        for shape in shapes {
            if shape.orientation.rawValue == direction.orientation.rawValue &&
                shape.location == bound - 1
            {
                updatBoundShape(bound: bound, boundShape: shape)
            }
            else if shape.orientation == Shape.shapeOrientation.PIVOT {
                shape.updateCoordinates(orientation: direction.orientation)
            }
        }

    }
    
    func updatBoundShape(bound: Int, boundShape: Shape) {
        if bound == 5 || bound == 1 {
            cloneShape(sourceShape: boundShape, direction: direction.orientation)
        }
        else if direction.moveDirection == .UP || direction.moveDirection == .RIGHT
        {
            boundShape.location = -1
            boundShape.updateCoordinates(orientation: direction.orientation)
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        if(direction.moveDirection != .NONE) {
            moveShapes(direction: direction)
        }
    }
    
    func moveShapes(direction: Direction) {
        var activeShapes: Int = 0;
        for shape in shapes {
            if shape.orientation.rawValue == direction.orientation.rawValue ||
                shape.orientation == Shape.shapeOrientation.PIVOT
            {
                if shape.animated < shape.animation {
                    shape.move(direction: direction.moveDirection, increment: increment)
                }
                else {
                    if self.direction.moveDirection != .NONE {
                        self.direction.moveDirection = .NONE
                    }
                    if(shape.cloned) {
                        shapes.remove(at: shapes.index(of: shape)!)
                        shape.removeFromParent()
                        shape.opacity.removeFromParent()
                    }
                    shape.changeLocation(direction: direction,
                                         bound: getMoveBound(moveDirection: direction.moveDirection))
                }
                activeShapes += 1
            }
        }
        
        if(activeShapes == 0) {
            self.direction.moveDirection = .NONE
        }
    }
    
    private func getMoveBound(moveDirection: moveDirection)->Int {
        let bound = shapesAmount[direction.orientation]!
        if bound > 5 {
            return bound
        }
        else if direction.moveDirection == .LEFT || direction.moveDirection == .DOWN {
            return 1
        }
        
        return 5
    }
    
    func cloneShape(sourceShape: Shape, direction: moveDirection) {
        print("clone")
        let newShape = Shape(shape: sourceShape)
        shapes.append(newShape)
        region.addChild(newShape)
        if sourceShape.location == 0 {
            sourceShape.location = 5
        }
        else {
            sourceShape.location = -1;
        }
        sourceShape.updateCoordinates(orientation: direction)
    }
    
    func getShape(orientation: moveDirection, id: Int) -> Shape? {
        for shape in shapes {
            if shape.orientation.rawValue == orientation.rawValue && shape.location == id {
                return shape
            }
        }
        return nil
    }
    
    
    func writeToFile() {
        //let documentDirectory = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // create the destination url for the text file to be saved
        //let fileURL = documentDirectory.appendingPathComponent("file.txt")
        //print("directory", fileURL)
        
        let filePath = Bundle.main.url(forResource: "Dark", withExtension: "txt")
        //         reading from disk
        do {
            let mytext = try String(contentsOf: filePath!)
            print(mytext)   // "some text\n"
            print(mytext.components(separatedBy: .newlines))
        } catch {
            print("error loading contents of:", filePath as Any, error)
        }
        //        let text = "some text"
        //        do {
        //            // writing to disk
        //            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        //
        //            // saving was successful. any code posterior code goes here
        
        //        }
        //            catch {
        //            print("error writing to url:", fileURL, error)
        //        }
    }
}
