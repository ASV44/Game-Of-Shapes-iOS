//
//  MainMenuScene.swift
//  Game_Of_Shapes_iOS
//
//  Created by Hackintosh on 6/2/17.
//  Copyright © 2017 Hackintosh. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    
    override func sceneDidLoad() {
        let displaySize: CGRect = UIScreen.main.bounds
        print(displaySize.width)
        print(displaySize.height)
        //self.scaleMode = .aspectFill
        self.size = CGSize(width: displaySize.width, height: displaySize.height)
        let background = SKSpriteNode(imageNamed: "menu.png")
        background.size = CGSize(width: displaySize.width, height: displaySize.height)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        addChild(background)
    }
}
