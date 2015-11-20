//
//  heroSpriteNode.swift
//  SwiftTVGame
//
//  Created by Alan Scarpa on 11/20/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import UIKit
import SpriteKit

class HeroSpriteNode: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "hero")
        self.size = CGSizeMake(self.texture!.size().width, self.texture!.size().height);
        self.userInteractionEnabled = true
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("touched!!!")
//        for touch in touches {
//            let location = touch.locationInNode(self.parent!)
//            print("Location is: ", location)
//            self.position.x = location.x - (location.x - self.position.x)
//            self.position.y = location.y - (location.y - self.position.y)
//        }
//    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let currentLocation = touch.locationInNode(self.parent!)
            let previousLocation = touch.previousLocationInNode(self.parent!)
            
            let distanceMovedX = currentLocation.x - previousLocation.x
            let distanceMovedY = currentLocation.y - previousLocation.y
            
            self.position.x = self.position.x + distanceMovedX
            self.position.y = self.position.y + distanceMovedY
        }
    }
    
}
