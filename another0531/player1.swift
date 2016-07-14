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

var WinOrNot = 3//3 means still running, 2 means Win and 1 means failed beacause tankhero is killed, and 0 means boss is killed!
var hit = 0
var pointx = 0
var pointy = 0
var grade = 0

class NewGameSceneplayer1: SKScene {
    
    var Tank_X: CGFloat = 0.0;
    var Tank_Y: CGFloat = 0.0;
    
    let tankhero = TankHero()
    let button = Button()
    var map = FightMap()
    var enemies = Tankenemies()
    var timeSinceLast:CFTimeInterval = 0.0
    var timeSinceLast1:CFTimeInterval = 0.0

    var lastUpdateTimeInterval:CFTimeInterval = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Tank_X = size.width / 4+30*10
        Tank_Y = size.height * 0+30
        
        map.DrawFightMap()
        DrawMap()
        
        enemies.SetEnemiesPosition(size.width / 4+30, b:size.height - 30,c: size.width/4, d:size.height)
        
        initLabel()
        initBackground()
        initTank()
        initenemies()
        
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
                    if((Tank_Y <= size.height - 43)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map1, dire: tankhero.direction)))
                    {
                        let judge_X = Int(Tank_Y/30)
                        let judge_Y = Int((Tank_X - size.width/4)/30)
                        map.map1[(judge_X-1)*26+judge_Y].state = 0
                        map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                        map.map1[(judge_X+1)*26+judge_Y].state = 9
                        map.map1[(judge_X+1)*26+judge_Y-1].state = 9
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
                    if((Tank_Y >= 40)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map1, dire: tankhero.direction)))
                    {
                        let judge_X = Int(Tank_Y/30)
                        let judge_Y = Int((Tank_X - size.width/4)/30)
                        map.map1[(judge_X)*26+judge_Y].state = 0
                        map.map1[(judge_X)*26+judge_Y-1].state = 0
                        map.map1[(judge_X-2)*26+judge_Y].state = 9
                        map.map1[(judge_X-2)*26+judge_Y-1].state = 9
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
                    if((Tank_X >= (size.width/4 + 40))&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map1, dire: tankhero.direction)))
                    {
                        let judge_X = Int(Tank_Y/30)
                        let judge_Y = Int((Tank_X - size.width/4)/30)
                        map.map1[(judge_X)*26+judge_Y].state = 0
                        map.map1[(judge_X-1)*26+judge_Y].state = 0
                        map.map1[(judge_X)*26+judge_Y-2].state = 9
                        map.map1[(judge_X-1)*26+judge_Y-2].state = 9
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
                    if((Tank_X <= size.width/8*6.5 - 10)&&(tankhero.JudgeTankandWall(Tank_X - size.width / 4, Tank_Y: Tank_Y, a: map.map1, dire: tankhero.direction)))
                    {
                        let judge_X = Int(Tank_Y/30)
                        let judge_Y = Int((Tank_X - size.width/4)/30)
                        map.map1[(judge_X)*26+judge_Y-1].state = 0
                        map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                        map.map1[(judge_X-1)*26+judge_Y+1].state = 9
                        map.map1[(judge_X)*26+judge_Y+1].state = 9
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
                tankhero.bombList.bombList.appendToTail(listnode)
                
            }
            
        }
        
    }
    
    func restart()
    {
        
        Tank_X = size.width / 4+30*10
        Tank_Y = size.height * 0+30
        
        map.DrawFightMap()
        DrawMap()
        
        enemies.SetEnemiesPosition(size.width / 4+30, b:size.height - 30,c: size.width/4, d:size.height)
        
        initLabel()
        initBackground()
        initTank()
        initenemies()
    }
    
    func ShowWinnerWidow()
    {
        let label = SKLabelNode(fontNamed:"MarkerFelt-Thin")
        label.text = "You win!"
        label.zPosition = 2
        label.fontColor = SKColor.orangeColor()
        label.setScale(5)
        label.position = CGPointMake(self.size.width/2+50, self.size.height/2 + 20)
        self.addChild(label)
    }
    
    func ShowFailedWindow()
    {
        let label = SKLabelNode(fontNamed:"MarkerFelt-Thin")
        label.text = "GameOver!"
        label.zPosition = 2
        label.fontColor = SKColor.orangeColor()
        label.setScale(5)
        label.position = CGPointMake(self.size.width/2+50, self.size.height/2 + 20)
        self.addChild(label)
    }
    
    func JudgeWinOrNot()
    {
        if(WinOrNot == 2)
        {
            ShowWinnerWidow()
        }
        else if(WinOrNot == 1)
        {
             ShowFailedWindow()
        }
        else if(WinOrNot == 0)
        {
            map.map1[12].Wall.hidden = true
            let BossTexture = SKTexture(imageNamed: "FailedBoss")
            map.map1[12].state = 0
            map.map1[12].Wall = SKSpriteNode(texture:BossTexture)
            map.map1[12].Wall.position = CGPointMake((size.width/4 + 390.0),(30.0))
            map.map1[12].Wall.size = CGSizeMake(60, 60)
            self.addChild(map.map1[12].Wall)
            ShowFailedWindow()
        }
        if(hit == 1)
        {
            var judge_X = Int(enemies.enemy1.Tank_Y/30)
            var judge_Y = Int((enemies.enemy1.Tank_X - size.width/4)/30)
            if(judge_X == pointx && judge_Y == pointy)
            {
                enemies.enemy1.TankEnemyDown.hidden = true
                enemies.enemy1.TankEnemyLeft.hidden = true
                enemies.enemy1.TankEnemyRight.hidden = true
                enemies.enemy1.TankEnemyUp.hidden = true
                map.map1[judge_X*26+judge_Y].state = 0
                map.map1[(judge_X-1)*26+judge_Y].state = 0
                map.map1[judge_X*26+judge_Y-1].state = 0
                map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                enemies.enemy1.status = 0
            }
            else {
                judge_X = Int(enemies.enemy2.Tank_Y/30)
                judge_Y = Int((enemies.enemy2.Tank_X - size.width/4)/30)
                if(judge_X == pointx && judge_Y == pointy)
                {
                    enemies.enemy2.TankEnemyDown.hidden = true
                    enemies.enemy2.TankEnemyLeft.hidden = true
                    enemies.enemy2.TankEnemyRight.hidden = true
                    enemies.enemy2.TankEnemyUp.hidden = true
                    map.map1[judge_X*26+judge_Y].state = 0
                    map.map1[(judge_X-1)*26+judge_Y].state = 0
                    map.map1[judge_X*26+judge_Y-1].state = 0
                    map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                    enemies.enemy2.status = 0
                }
                else
                {
                    judge_X = Int(enemies.enemy3.Tank_Y/30)
                    judge_Y = Int((enemies.enemy3.Tank_X - size.width/4)/30)
                    if(judge_X == pointx && judge_Y == pointy)
                    {
                        enemies.enemy3.TankEnemyDown.hidden = true
                        enemies.enemy3.TankEnemyLeft.hidden = true
                        enemies.enemy3.TankEnemyRight.hidden = true
                        enemies.enemy3.TankEnemyUp.hidden = true
                        map.map1[judge_X*26+judge_Y].state = 0
                        map.map1[(judge_X-1)*26+judge_Y].state = 0
                        map.map1[judge_X*26+judge_Y-1].state = 0
                        map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                       // enemies.enemy3.setTankPosition(size.width / 4+30, b:size.height - 30,c: size.width/4, d:size.height)
                        enemies.enemy3.status = 0
                    }
                        else
                    {
                        judge_X = Int(enemies.enemy4.Tank_Y/30)
                        judge_Y = Int((enemies.enemy4.Tank_X - size.width/4)/30)
                        if(judge_X == pointx && judge_Y == pointy)
                        {
                            enemies.enemy4.TankEnemyDown.hidden = true
                            enemies.enemy4.TankEnemyLeft.hidden = true
                            enemies.enemy4.TankEnemyRight.hidden = true
                            enemies.enemy4.TankEnemyUp.hidden = true
                            map.map1[judge_X*26+judge_Y].state = 0
                            map.map1[(judge_X-1)*26+judge_Y].state = 0
                            map.map1[judge_X*26+judge_Y-1].state = 0
                            map.map1[(judge_X-1)*26+judge_Y-1].state = 0
                            enemies.enemy4.status = 0
                        }
                    }
                }
            }
            hit = 0
            enemies.count--
            grade++
        }
        if(grade >= 4)
        {
            WinOrNot = 2
        }
    }


    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        timeSinceLast = currentTime - lastUpdateTimeInterval + timeSinceLast
        timeSinceLast1 = currentTime - lastUpdateTimeInterval + timeSinceLast1
        lastUpdateTimeInterval = currentTime
        
        let location = CGPoint(x: Tank_X, y: Tank_Y)
        tankhero.TankMove(location)
        
        /*update the bomb position*/
        tankhero.bombList.BombListMove(map.map1,b: size.width/4)
        if(timeSinceLast > 0.5)
        {
            timeSinceLast = 1.0/60.0
            lastUpdateTimeInterval = currentTime

            enemies.EnemiesMove(map.map1)
        }
                JudgeWinOrNot()
        
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
        self.addChild(button.RestartLabel)
        button.RestartLabel.hidden = true
        
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
    
    func initenemies()
    {
        self.addChild(enemies.enemy1.TankEnemyDown)
        self.addChild(enemies.enemy1.TankEnemyUp)
        self.addChild(enemies.enemy1.TankEnemyLeft)
        self.addChild(enemies.enemy1.TankEnemyRight)
        
        self.addChild(enemies.enemy2.TankEnemyDown)
        self.addChild(enemies.enemy2.TankEnemyUp)
        self.addChild(enemies.enemy2.TankEnemyLeft)
        self.addChild(enemies.enemy2.TankEnemyRight)
        
        self.addChild(enemies.enemy3.TankEnemyDown)
        self.addChild(enemies.enemy3.TankEnemyUp)
        self.addChild(enemies.enemy3.TankEnemyLeft)
        self.addChild(enemies.enemy3.TankEnemyRight)
        
        self.addChild(enemies.enemy4.TankEnemyDown)
        self.addChild(enemies.enemy4.TankEnemyUp)
        self.addChild(enemies.enemy4.TankEnemyLeft)
        self.addChild(enemies.enemy4.TankEnemyRight)
    }
    
    func DrawMap()
    {
        let BasicWallTexture = SKTexture(imageNamed: "Brick")
        let SlabWallTexture = SKTexture(imageNamed: "Slab")
        let RiverWallTexture = SKTexture(imageNamed: "River")
        let GrassWallTexture = SKTexture(imageNamed: "Grass")
        let BossTexture = SKTexture(imageNamed: "Boss")
        
        for var i=0;i<25;i++
        {
            for var j=0;j<26;j++
            {
                if(map.map1[i*26+j].state == 1)
                {
                    map.map1[i*26+j].Wall = SKSpriteNode(texture:BasicWallTexture)
                    let recordheight:CGFloat = CGFloat(30*i)
                    let recordwidth:CGFloat = CGFloat(30*j)
                    map.map1[i*26+j].Wall.position = CGPointMake((size.width/4+recordwidth+15),(recordheight+15))
                    map.map1[i*26+j].Wall.size=CGSizeMake(30, 30)
                    self.addChild(map.map1[i*26+j].Wall)
                }
                else if(map.map1[i*26+j].state == 2)
                {
                    map.map1[i*26+j].Wall = SKSpriteNode(texture:SlabWallTexture)
                    let recordheight:CGFloat = CGFloat(30*i)
                    let recordwidth:CGFloat = CGFloat(30*j)
                    map.map1[i*26+j].Wall.position = CGPointMake((size.width/4+recordwidth+15),(recordheight+15))
                    map.map1[i*26+j].Wall.size=CGSizeMake(30, 30)
                    self.addChild(map.map1[i*26+j].Wall)
                }
                else if(map.map1[i*26+j].state == 3)
                {
                    map.map1[i*26+j].Wall = SKSpriteNode(texture:RiverWallTexture)
                    let recordheight:CGFloat = CGFloat(30*i)
                    let recordwidth:CGFloat = CGFloat(30*j)
                    map.map1[i*26+j].Wall.position = CGPointMake((size.width/4+recordwidth+15),(recordheight+15))
                    map.map1[i*26+j].Wall.size=CGSizeMake(30, 30)
                    self.addChild(map.map1[i*26+j].Wall)
                }
                else if(map.map1[i*26+j].state==4)
                {
                    map.map1[i*26+j].Wall = SKSpriteNode(texture:GrassWallTexture)
                    let recordheight:CGFloat = CGFloat(30*i)
                    let recordwidth:CGFloat = CGFloat(30*j)
                    map.map1[i*26+j].Wall.position = CGPointMake((size.width/4+recordwidth+15),(recordheight+15))
                    map.map1[i*26+j].Wall.size=CGSizeMake(30, 30)
                    self.addChild(map.map1[i*26+j].Wall)
                }
                else if(map.map1[i*26+j].state == 5)
                {
                    map.map1[i*26+j].Wall = SKSpriteNode(texture:BossTexture)
                    let recordheight:CGFloat = CGFloat(30*i)
                    let recordwidth:CGFloat = CGFloat(30*j)
                    map.map1[i*26+j].Wall.position = CGPointMake((size.width/4+recordwidth+30),(recordheight+30))
                    map.map1[i*26+j].Wall.size=CGSizeMake(60, 60)
                    self.addChild(map.map1[i*26+j].Wall)
                }
            }
        }
    }
}

