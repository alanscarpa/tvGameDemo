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
        startShootingAtHero()
    }
    
    func loadHeroOntoScreen() {
        self.addChild(hero)
        hero.position = CGPointMake(hero.texture!.size().width / 2, self.frame.size.height / 2)
    }
    
    func startShootingAtHero() {
        var bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = CGPointMake(self.frame.size.width + 20, self.frame.size.height / 2)
        self.addChild(bullet)
        bullet.runAction(SKAction.moveTo(CGPointMake(-((bullet.texture?.size().width)! + 20), self.frame.size.height / 2), duration: 2.0)) { () -> Void in
            self.startShootingAtHero()
        };
        
    }
    
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

}
