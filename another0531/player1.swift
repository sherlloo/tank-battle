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
    let map = FightMap()
    
    var bombList: BombList = BombList()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Tank_X = size.width / 4+30
        Tank_Y = size.height * 0+60
        
        initLabel()
        initBackground()
        initTank()
        map.DrawFightMap()
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
                    if((Tank_Y <= size.height - 43)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map, dire: tankhero.direction)))
                    {
                        Tank_Y += 30
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
                    if((Tank_Y >= 40)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map, dire: tankhero.direction)))
                    {
                        Tank_Y -= 30
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
                    if((Tank_X >= (size.width/4 + 40))&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map, dire: tankhero.direction)))
                    {
                        Tank_X -= 30
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
                    if((Tank_X <= size.width/8*6.5 - 10)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map, dire: tankhero.direction)))
                    {
                        Tank_X += 30
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
        let BasicWallTexture = SKTexture(imageNamed: "Brick")
        let SlabWallTexture = SKTexture(imageNamed: "Slab")
        let RiverWallTexture = SKTexture(imageNamed: "River")
        let GrassWallTexture = SKTexture(imageNamed: "Grass")
        let BossTexture = SKTexture(imageNamed: "Boss")
        for var i=0;i<12;i++
        {
            for var j=0;j<13;j++
            {
                if(map.map[i][j] == 1)
                {
                    let basicwall = SKSpriteNode(texture:BasicWallTexture)
                    let recordheight:CGFloat = CGFloat(60*i)
                    let recordwidth:CGFloat = CGFloat(60*j)
                    basicwall.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    basicwall.size=CGSizeMake(60, 60)
                    self.addChild(basicwall)
                }
                else if(map.map[i][j] == 2)
                {
                    let slabwall = SKSpriteNode(texture:SlabWallTexture)
                    let recordheight:CGFloat = CGFloat(60*i)
                    let recordwidth:CGFloat = CGFloat(60*j)
                    slabwall.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    slabwall.size=CGSizeMake(60, 60)
                    self.addChild(slabwall)

                }
                else if(map.map[i][j] == 3)
                {
                    let riverwall = SKSpriteNode(texture:RiverWallTexture)
                    let recordheight:CGFloat = CGFloat(60*i)
                    let recordwidth:CGFloat = CGFloat(60*j)
                    riverwall.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    riverwall.size=CGSizeMake(60, 60)
                    self.addChild(riverwall)
                }
                else if(map.map[i][j]==4)
                {
                    let grasswall = SKSpriteNode(texture:GrassWallTexture)
                    let recordheight:CGFloat = CGFloat(60*i)
                    let recordwidth:CGFloat = CGFloat(60*j)
                    grasswall.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    grasswall.size=CGSizeMake(60, 60)
                    self.addChild(grasswall)
                }
                else if(map.map[i][j] == 5)
                {
                    let boss = SKSpriteNode(texture:BossTexture)
                    let recordheight:CGFloat = CGFloat(60*i)
                    let recordwidth:CGFloat = CGFloat(60*j)
                    boss.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    boss.size=CGSizeMake(60, 60)
                    self.addChild(boss)
                }
            }
        }
    }
}

