//
//  player1.swift
//  another0531
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

//import Foundation

import SpriteKit
import UIKit

enum Direction{
    case UP, DOWN, LEFT, RIGHT
};


class NewGameSceneplayer1: SKScene {
    
    var Tank_X: CGFloat = 0.0;
    var Tank_Y: CGFloat = 0.0;
    
    let tankhero = TankHero()
    let button = Button()
    
    var bombList: BombList = BombList()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Tank_X = size.width * 0.5
        Tank_Y = size.height * 0.6
        
        initLabel()
        initBackground()
        initTank()
        DrawMap()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            if(CGRectContainsPoint(button.upLabel.frame, location)){
                
                button.upLabel.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                if(tankhero.direction != Direction.UP)
                {
                    tankhero.AdjustDirection(Direction.UP)
                }
                else
                {
                    if(Tank_Y <= size.height - 43)
                    {
                        Tank_Y += 20
                    }
                    
                }
            }
            else if(CGRectContainsPoint(button.downLabel.frame, location)){
                
                button.downLabel.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                if(tankhero.direction != Direction.DOWN)
                {
                    tankhero.AdjustDirection(Direction.DOWN)
                }
                else
                {
                    if(Tank_Y >= 40)
                    {
                        Tank_Y -= 20
                    }
                }
            }
            else if(CGRectContainsPoint(button.leftLabel.frame, location)){
                
                button.leftLabel.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                if(tankhero.direction != Direction.LEFT)
                {
                    tankhero.AdjustDirection(Direction.LEFT);
                }
                else
                {
                    if(Tank_X >= (size.width/4 + 40))
                    {
                        Tank_X -= 20
                    }
                }
            }
                
            else if(CGRectContainsPoint(button.rightLabel.frame, location)){
                
                button.rightLabel.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                if(tankhero.direction != Direction.RIGHT)
                {
                    tankhero.AdjustDirection(Direction.RIGHT)
                }
                else
                {
                    if(Tank_X <= size.width/8*6.5 - 40)
                    {
                        Tank_X += 20
                    }
                }
            }
            else if(CGRectContainsPoint(button.attackLabel.frame, location)){
                button.attackLabel.runAction(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.1),SKAction.scaleTo(1, duration: 0.3)]))
                
                let bomb: Bomb = Bomb(_dir: tankhero.direction, _point: CGPointMake(Tank_X, Tank_Y))
                let listnode: ListNode<Bomb> = ListNode(_key: bomb)
                
                self.addChild(bomb.bomb)
                
//                bombList.appendToTail(listnode)
                bombList.bombList.appendToTail(listnode)
                
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let location = CGPoint(x: Tank_X, y: Tank_Y)
        tankhero.TankMove(location)
        
        /*update the bomb position*/
        bombList.BombListMove()
        
    }
    
    
    func initLabel(){
        button.SetButtonPosition(self.size.width/8 + 20, Y: self.size.height/2)
        
        UpBound.x = 0
        UpBound.y = self.size.height
        
        DownBound.x = 0
        DownBound.y = 0
        
    }
    
    func initBackground(){
        /*横屏*/
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        
        backgroundColor = UIColor.blackColor()
        
        self.addChild(button.upLabel)
        self.addChild(button.downLabel)
        self.addChild(button.leftLabel)
        self.addChild(button.rightLabel)
        self.addChild(button.attackLabel)
        
        self.addChild(button.FightViewl)
        self.addChild(button.FightViewr)
        
    }
    
    
    func initTank(){
        
        self.addChild(tankhero.TankHeroUp)
        self.addChild(tankhero.TankHeroDown)
        self.addChild(tankhero.TankHeroLeft)
        self.addChild(tankhero.TankHeroRight)
        
        tankhero.SetTankPosition(Tank_X, Tank_Y:Tank_Y)
        
    }
    
    func DrawMap()
    {
        var i:CGFloat = 20.0;
        i = size.height/2
//        for(;i <= size.height - 20; i=i+30)
//        {
            let BasicWallTexture = SKTexture(imageNamed: "Brick")
            let basicwall = SKSpriteNode(texture:BasicWallTexture)
            basicwall.position = CGPointMake(size.width/4+30, i)
            basicwall.setScale(1)
            self.addChild(basicwall)
//        }
        
        
        let BasicWallTexture2 = SKTexture(imageNamed: "Slab")
        let basicwall2 = SKSpriteNode(texture:BasicWallTexture2)
        basicwall2.position = CGPointMake(size.width/4+100, i)
        basicwall2.setScale(24/27)
        self.addChild(basicwall2)
        
//        var fightMap: FightMap = FightMap(_stage: 1, _scene: self)
        
//        fightMap.DrawFightMap()
        
        
        tankhero.TankHeroUp.size.height = 60
        tankhero.TankHeroUp.size.width = 60
        
        NSLog("width = %f height = %f", basicwall.size.width, basicwall.size.height)

        NSLog("width = %f height = %f", basicwall2.size.width, basicwall2.size.height)
        
        NSLog("width = %f height = %f", tankhero.TankHeroUp.size.width, tankhero.TankHeroUp.size.height)
        
        NSLog("width = %f height = %f", self.size.width, self.size.height)
        
        NSLog("width = %f", RightBound.x - LeftBound.x)
    }
}









/*
//
//  player1.swift
//  another0531
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

//import Foundation

import SpriteKit


enum Direction{
    case UP
    case DOWN
    case LEFT
    case RIGHT
};

class NewGameSceneplayer1: SKScene {
    
    let upLabel    = SKLabelNode(text: "Chalkduster")
    let downLabel  = SKLabelNode(text: "Chalkduster")
    let leftLabel  = SKLabelNode(text: "Chalkduster")
    let rightLabel = SKLabelNode(text: "Chalkduster")
    
    
    let attackLabel = SKLabelNode(text: "Chalkduster")
    
    var direction = Direction.DOWN

/*
    let DirectionViewTexture = SKTexture(imageNamed: "DirectionBackGround")
    var DirectionView = SKSpriteNode()
 */
    var Tank_X: CGFloat = 0.0;
    var Tank_Y: CGFloat = 0.0;
    
    let FightViewTexture = SKTexture(imageNamed: "BackGround")
    var FightView = SKSpriteNode()
    
    let TankHeroTexture = SKTexture(imageNamed: "Tank")
    var TankHero = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Tank_X = size.width * 0.5
        Tank_Y = size.height * 0.6
        
        initLabel()
        initBackground()
        initTank()
        
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
        
        for touch in touches {
            let location = touch.locationInNode(self)
            if(CGRectContainsPoint(upLabel.frame, location)){
                
                    Tank_Y += 20
            }
            else if(CGRectContainsPoint(downLabel.frame, location)){
                
                Tank_Y -= 20
            }
            else if(CGRectContainsPoint(attackLabel.frame, location)){
                
            }

        }
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let location = CGPoint(x: Tank_X, y: Tank_Y)
        TankHero.runAction(SKAction.moveTo(location, duration: 0.1))
    }
    
    
  /*  func tapped(button:UIButton){
       print(button.titleForState(.Normal))
 }*/
    
    
    func initLabel(){
        upLabel.name = "Up"
        upLabel.text = "U";
        upLabel.fontSize = 80
        upLabel.fontColor = SKColor.orangeColor()
        upLabel.position = CGPointMake(self.size.width/8 + 20, self.size.height/2)
        
        downLabel.name = "Down"
        downLabel.text = "D";
        downLabel.fontSize = 80
        downLabel.fontColor = SKColor.orangeColor()
        downLabel.position = CGPointMake(self.size.width/8 + 20, upLabel.position.y - 90)

        leftLabel.name = "Left"
        leftLabel.text = "L";
        leftLabel.fontSize = 80
        leftLabel.fontColor = SKColor.orangeColor()
        leftLabel.position = CGPointMake(self.size.width/8 - 70, upLabel.position.y - 90)

        rightLabel.name = "Right"
        rightLabel.text = "R";
        rightLabel.fontSize = 80
        rightLabel.fontColor = SKColor.orangeColor()
        rightLabel.position = CGPointMake(self.size.width/8 + 110, upLabel.position.y - 90)
        
        attackLabel.name = "Attack"
        attackLabel.text = "A";
        attackLabel.fontSize = 120;
        attackLabel.fontColor = SKColor.orangeColor()
        attackLabel.position = CGPointMake(self.size.width/8*7, self.size.height/2 - 90)

        FightView = SKSpriteNode(texture: FightViewTexture)
        FightView.position = CGPointMake(self.size.width/2 , self.size.height * 0.6)
        
//        DirectionView = SKSpriteNode(texture: DirectionViewTexture)
//       DirectionView.position = CGPoint(x: 0, y: 0)
//        DirectionView.setScale(2.2)
        
    }
    
    func initBackground(){
        /*横屏*/
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        
        backgroundColor = UIColor.blackColor()
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
//        self.addChild(myLabel)
        
//        self.addChild(DirectionView)
        
        self.addChild(upLabel)
        self.addChild(downLabel)
        self.addChild(leftLabel)
        self.addChild(rightLabel)
        
        self.addChild(attackLabel)
        
//        self.addChild(DirectionView)
        
//        self.addChild(FightView)
        
/*
        let fightView = UIView(frame: CGRect(x: self.size.width/8, y: 0, width: self.size.width/4, height: self.size.height))
        fightView.backgroundColor = UIColor.grayColor()
        
        self.view?.addSubview(fightView)
*/
        
        
        
    }
    
    
    func initTank(){
       
        TankHero = SKSpriteNode(texture:TankHeroTexture)
        
        TankHero.position = CGPointMake(Tank_X, Tank_Y)
        TankHero.setScale(1.5)
        TankHero.name = "TankHero"
        self.addChild(TankHero)
        
//        self.addChild(FightView)
        
                
        NSLog("Tank_width = %f Tank_height = %f", TankHero.size.width, TankHero.size.height)
        
        
    }
    
}

*/
