//
//  player2.swift
//  another0531
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

import SpriteKit

class NewGameSceneplayer2: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /*横屏*/
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        
        backgroundColor = UIColor.yellowColor()
        let myLabel1 = SKLabelNode(fontNamed:"Chalkduster")
        myLabel1.text = "Hello, World!"
        myLabel1.fontSize = 45
        myLabel1.color = UIColor.blackColor()
        myLabel1.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* for touch in touches {
        let location = touch.locationInNode(self)
        
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
        }*/
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /*  func tapped(button:UIButton){
    print(button.titleForState(.Normal))
    }*/
}