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
        
        let playButtonSize = CGSize(width: 0.569 * displaySize.width, height: 0.320 * displaySize.height)
        let playButton = SKSpriteNode(color: SKColor.clear, size: playButtonSize)
        playButton.anchorPoint = CGPoint(x: 0, y: 0)
        playButton.position = CGPoint(x: 0.212 * displaySize.width, y: 0.463 * displaySize.height)
        playButton.name = "playButton"
        addChild(background)
        addChild(playButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let touchNode = atPoint(location)
            
            if touchNode.name == "playButton" {
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                let gameScene:SKScene = GameScene()
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
