//
//  GameScene.swift
//  another0531
//
//  Created by Apple on 16/5/31.
//  Copyright (c) 2016年 Apple. All rights reserved.
//
import UIKit
import SpriteKit

class GameScene: SKScene {
    let myplayer1 = SKLabelNode(text: "Chalkduster")
    let myplayer2 = SKLabelNode(text: "Chalkduster")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor.blackColor()
        let backgroundTexture = SKTexture(imageNamed: "BackGround")
        let background = SKSpriteNode(texture: backgroundTexture)
        background.position = CGPointMake(size.width*0.5, size.height*0.6)
        background.setScale(1)
        background.name="background"
        self.addChild(background)
        
        
       // let myplayer1 = SKLabelNode(text: "Chalkduster")
        myplayer1.name = "MyPlayer1"
        myplayer1.text = "Player1"
        myplayer1.fontName = "MarkerFelt-Thin"
        myplayer1.fontSize = 40
        myplayer1.fontColor = SKColor.orangeColor()
        myplayer1.position = CGPointMake(self.size.width/2, self.size.height/3)
        self.addChild(myplayer1)
        
        
    //    let myplayer2 = SKLabelNode(text: "Chalkduster")
        myplayer2.name = "MyPlayer2"
        myplayer2.text = "Player2"
        myplayer2.fontName = "MarkerFelt-Thin"
        myplayer2.fontSize = 40
        myplayer2.fontColor = SKColor.orangeColor()
        myplayer2.position = CGPointMake(self.size.width/2, self.size.height/4)
        self.addChild(myplayer2)

//        let myplayer2:UIButton = UIButton(type:.Custom)
//        myplayer2.frame = CGRectMake(150,450,100,30)
//        myplayer2.setTitle("Player2",forState:UIControlState.Normal)
//        myplayer2.setTitleColor(UIColor.orangeColor(), forState: .Normal)
       // self.view?.addSubview(myplayer2)
     
      //  myplayer1.addTarget(self,action:Selector("tapped:"),forControlEvents:UIControlEvents.TouchUpInside)
     
       // myplayer2.addTarget(self,action:Selector("tapped:"),forControlEvents:UIControlEvents.TouchUpInside)
        
        
        
     /*   let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
        for touch in touches {
            let location = touch.locationInNode(self)
          if(CGRectContainsPoint(myplayer1.frame, location))
          {
            let nextScene=NewGameSceneplayer1(size:CGSizeMake(1334, 750))
            let skView1 = self.view! as SKView
            skView1.showsFPS = true
            skView1.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView1.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            nextScene.scaleMode = .AspectFill
            
            skView1.presentScene(nextScene)

            }
            else if(CGRectContainsPoint(myplayer2.frame,location ))
          {
            let nextScene=NewGameSceneplayer2(size:CGSizeMake(1334, 750))
            let skView2 = self.view! as SKView
            skView2.showsFPS = true
            skView2.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView2.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            nextScene.scaleMode = .AspectFill
            
            skView2.presentScene(nextScene)
            

            }
        
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self);
            
            if(CGRectContainsPoint(myplayer1.frame, location))
            {
                myplayer1.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                
                
            }
            else if(CGRectContainsPoint(myplayer2.frame, location))
            {
                myplayer2.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]));
                           }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func tapped(button:UIButton){
        
        //self.view?.presentScene(nextScene)
    }

}

