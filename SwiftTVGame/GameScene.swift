//
//  GameScene.swift
//  SwiftTVGame
//
//  Created by Alan Scarpa on 11/19/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var hero = HeroSpriteNode()
    
    override func didMoveToView(view: SKView) {
        loadHeroOntoScreen()
    }
    
    func loadHeroOntoScreen() {
        self.addChild(hero)
        hero.position = CGPointMake(hero.texture!.size().width / 2, self.frame.size.height / 2)
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            print("Location is: ", location)
//            print("X: ", location.x - (location.x - hero.position.x))
//            print("Y: ",hero.position.y = location.y - (location.y - hero.position.y))
//            hero.position.x = location.x - (location.x - hero.position.x)
//            hero.position.y = location.y - (location.y - hero.position.y)
//        }
//    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let currentLocation = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            let distanceMovedX = currentLocation.x - previousLocation.x
            let distanceMovedY = currentLocation.y - previousLocation.y
            
            hero.position.x = hero.position.x + distanceMovedX
            hero.position.y = hero.position.y + distanceMovedY
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
