//
//  GameScene.swift
//  SwiftTVGame
//
//  Created by Alan Scarpa on 11/19/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

import SpriteKit

let heroBulletCategory:UInt32 = 1 << 0
let enemyBulletCategory:UInt32 = 1 << 1

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero = HeroSpriteNode()

    override func didMoveToView(view: SKView) {
        loadHeroOntoScreen()
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        self.physicsWorld.contactDelegate = self
        setUpTapGesture()
        startShootingAtHero()
    }
    
    func loadHeroOntoScreen() {
        self.addChild(hero)
        hero.position = CGPointMake(hero.texture!.size().width / 2, self.frame.size.height / 2)
    }
    
    func setUpTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: "fireBullet:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view!.addGestureRecognizer(tap)
    }
    
    func fireBullet(gesture: UITapGestureRecognizer) {
        let heroBullet = SKSpriteNode(imageNamed: "heroBullet")
        heroBullet.xScale = 0.5
        heroBullet.yScale = 0.5
        heroBullet.physicsBody = SKPhysicsBody(rectangleOfSize:heroBullet.size)
        heroBullet.physicsBody!.usesPreciseCollisionDetection = true
        heroBullet.physicsBody!.categoryBitMask = heroBulletCategory
        heroBullet.physicsBody!.contactTestBitMask = enemyBulletCategory
        heroBullet.physicsBody!.collisionBitMask = enemyBulletCategory
        heroBullet.zPosition = 200
        heroBullet.position = CGPointMake(hero.position.x, hero.position.y)
        self.addChild(heroBullet)
        heroBullet.runAction(SKAction.moveTo(CGPointMake(self.frame.size.width * 1.2, hero.position.y), duration: 1.0)) { () -> Void in
            heroBullet.removeFromParent()
        }
    }
    
    func startShootingAtHero() {
        let enemyBullet = SKSpriteNode(imageNamed: "enemyBullet")
        enemyBullet.zPosition = 200
        enemyBullet.xScale = 0.5
        enemyBullet.yScale = 0.5
        enemyBullet.physicsBody = SKPhysicsBody(rectangleOfSize:enemyBullet.size)
        enemyBullet.physicsBody!.usesPreciseCollisionDetection = true
        enemyBullet.physicsBody!.categoryBitMask = enemyBulletCategory
        enemyBullet.physicsBody!.contactTestBitMask = heroBulletCategory
        enemyBullet.physicsBody!.collisionBitMask = heroBulletCategory
        enemyBullet.position = CGPointMake(self.frame.size.width + 100, self.frame.size.height / 2)
        self.addChild(enemyBullet)
        enemyBullet.runAction(SKAction.moveTo(CGPointMake(-(enemyBullet.texture!.size().width + 20), self.frame.size.height / 2), duration: 2.0)) { () -> Void in
            enemyBullet.removeFromParent()
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if (contact.bodyA.categoryBitMask == enemyBulletCategory && contact.bodyB.categoryBitMask == heroBulletCategory
            || contact.bodyA.categoryBitMask == heroBulletCategory && contact.bodyB.categoryBitMask == enemyBulletCategory) {
            showExplosion(firstNode.position)
            firstNode.removeFromParent()
            secondNode.removeFromParent()
            startShootingAtHero()
        }
    }
    
    func showExplosion(position: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.zPosition = 400
        explosion.position = position
        explosion.xScale = 0.6
        explosion.yScale = 0.6
        self.addChild(explosion)
        explosion.runAction(SKAction.rotateByAngle(90.0, duration: 0.3)) { () -> Void in
            explosion.removeFromParent()
        }
    }
    
}
