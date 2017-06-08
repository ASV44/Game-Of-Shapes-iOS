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
    //TextureRegion region;
    let location: Int
    var animated: CGFloat
    var animation: CGFloat
    var regionWidth: CGFloat
    var regionHeight: CGFloat
    let id: Int
    let connect: String
    let opacity: SKSpriteNode
    //Opacity Region

    init(orientation: String, location: Int, shapeName: String) {
        let texture = SKTexture(imageNamed: shapeName)
        let displaySize: CGRect = UIScreen.main.bounds
        width = 0.1694 * displaySize.width
        height = 0.0973 * displaySize.height
        self.location = location
        animated = 0
        switch orientation {
        case "vertical":
            animation = 0.1077 * displaySize.height
            break
        case "horizontal":
            animation = 0.1925 * displaySize.height
        default:
            animation = 0
        }
        regionWidth = 256
        regionHeight = 256
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
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        anchorPoint = CGPoint(x: 0, y: 0)
        name = shapeName
        if orientation == "vertical" {
            position.x = 0.413 * displaySize.width
            let gap = CGFloat(location) * CGFloat(0.0104) * displaySize.height
            position.y = 0.210 *  displaySize.height + CGFloat(location) * CGFloat(height) + gap
        }
        if orientation == "horizontal" {
            let gap = CGFloat(location) * CGFloat(0.0231) * displaySize.width
            position.x = 0.0314 * displaySize.width + CGFloat(location) * CGFloat(width) + gap
            position.y = 0.426 * displaySize.height
        }
        size = CGSize(width: width, height: height)
        opacity.size = CGSize(width: width, height: height)
        opacity.position = position
        opacity.anchorPoint = CGPoint(x: 0, y: 0)
        opacity.zPosition = 1
        zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
