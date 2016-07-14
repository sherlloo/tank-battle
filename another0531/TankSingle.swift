//
//  TankSingle.swift
//  another0531
//
//  Created by Apple on 16/7/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

class TankSingle6 {
    var TankEnemyUpTexture = SKTexture(imageNamed: "Enemy6Up")
    var TankEnemyUp = SKSpriteNode()
    
    var TankEnemyDownTexture = SKTexture(imageNamed: "Enemy6Down")
    var TankEnemyDown = SKSpriteNode()
    
    var TankEnemyLeftTexture = SKTexture(imageNamed: "Enemy6Left")
    var TankEnemyLeft = SKSpriteNode()
    
    var TankEnemyRightTexture = SKTexture(imageNamed: "Enemy6Right")
    var TankEnemyRight = SKSpriteNode()
    
    var direction = Direction.UP
    var status = 0 //0 for dead, 1 for live
    
    var Tank_X:CGFloat = 0.0
    var Tank_Y:CGFloat = 0.0
    
    var reminder = 0
    var remider1 = 0
    
    var record = [RecordDirection]()  //0 means Up, 1 means Down, 2 means Left, 3 means Right;
    var record1 = [Direction]()
    
    init()
    {
        self.direction = Direction.DOWN
        self.status = 1
        
        TankEnemyUp = SKSpriteNode(texture:TankEnemyUpTexture)
        TankEnemyUp.size = CGSizeMake(60, 60)
        TankEnemyUp.name = "TankEnemyUp"
        TankEnemyUp.hidden = true
        
        TankEnemyDown = SKSpriteNode(texture:TankEnemyDownTexture)
        TankEnemyDown.size = CGSizeMake(60, 60)
        TankEnemyDown.name = "TankEnemyDown"
        TankEnemyDown.hidden = false
        
        TankEnemyLeft = SKSpriteNode(texture:TankEnemyLeftTexture)
        TankEnemyLeft.size = CGSizeMake(60, 60)
        TankEnemyLeft.name = "TankEnemyLeft"
        TankEnemyLeft.hidden = true
        
        TankEnemyRight = SKSpriteNode(texture:TankEnemyRightTexture)
        TankEnemyRight.size = CGSizeMake(60, 60)
        TankEnemyRight.name = "TankEnemyRight"
        TankEnemyRight.hidden = true
        
        for var i = 0;i<4;i++
        {
            let Re:RecordDirection = RecordDirection()
            record.append(Re)
        }
    }
    
    func setTankPosition(a: CGFloat, b: CGFloat, c:CGFloat, d:CGFloat)
    {
        self.Tank_X = a
        self.Tank_Y = b
        
        reminder = Int(c)
        remider1 = Int(d)
        
        TankEnemyUp.position = CGPointMake(a, b)
        
        TankEnemyDown.position = CGPointMake(a,b)
        
        TankEnemyLeft.position = CGPointMake(a, b)
        
        TankEnemyRight.position = CGPointMake(a, b)
    }
    
    func AdjustDirection(Direct:Direction)
    {
        if(Direct == Direction.UP)
        {
            TankEnemyDown.hidden = true
            TankEnemyLeft.hidden = true
            TankEnemyRight.hidden = true
            TankEnemyUp.hidden = false
            self.direction = Direction.UP
            
        }
        else if(Direct == Direction.DOWN)
        {
            TankEnemyDown.hidden = false
            TankEnemyLeft.hidden = true
            TankEnemyRight.hidden = true
            TankEnemyUp.hidden = true
            self.direction = Direction.DOWN
        }
        else if(Direct == Direction.LEFT)
        {
            TankEnemyDown.hidden = true
            TankEnemyLeft.hidden = false
            TankEnemyRight.hidden = true
            TankEnemyUp.hidden = true
            self.direction = Direction.LEFT
        }
        else
        {
            TankEnemyDown.hidden = true
            TankEnemyLeft.hidden = true
            TankEnemyRight.hidden = false
            TankEnemyUp.hidden = true
            self.direction = Direction.RIGHT
        }
    }
    
    func TankMove(location:CGPoint)
    {
        
        TankEnemyUp.runAction(SKAction.moveTo(location, duration: 0.5))
        TankEnemyDown.runAction(SKAction.moveTo(location, duration: 0.5))
        TankEnemyLeft.runAction(SKAction.moveTo(location, duration: 0.5))
        TankEnemyRight.runAction(SKAction.moveTo(location, duration: 0.5))
    }
    
    func ShowDir(a:[MapNode]) -> Int
    {
        var number = 0
        for var i=0;i<4;i++
        {
            record[i].record = false
        }
        if((Int(Tank_Y) <= remider1 - 43)&&(JudgeTankandWall(Tank_X, Tank_Y: Tank_Y, a:a, dire: Direction.UP)))
        {
            record[0].record = true
            record[0].dir = Direction.UP
            number++
        }
        if((Int(Tank_Y) >= 40 )&&(JudgeTankandWall(Tank_X, Tank_Y: Tank_Y, a:a, dire: Direction.DOWN)))
        {
            record[1].record = true
            record[1].dir = Direction.DOWN
            number++
        }
        if((Int(Tank_Y) >= reminder + 40)&&(JudgeTankandWall(Tank_X , Tank_Y: Tank_Y, a:a, dire: Direction.LEFT)))
        {
            record[2].record=true
            record[2].dir = Direction.LEFT
            number++
        }
        if((Double(Tank_X) <= Double(reminder/4 * 13) - 10)&&(JudgeTankandWall(Tank_X, Tank_Y: Tank_Y, a:a, dire: Direction.RIGHT)))
        {
            record[3].record = true
            record[3].dir = Direction.RIGHT
            number++
        }
        return number
    }
    
    func GenerateDir(a:[MapNode]) -> Direction
    {
        let num = ShowDir(a)
        var dir = Direction.LEFT
        if(num == 1)
        {
            for var i=0;i<4;i++
            {
                if(record[i].record == true)
                {
                    dir = record[i].dir
                }
                
            }
        }
        else if(num > 1){
            var j=0
            for var i=0;i<4;i++
            {
                if(record[i].record == true)
                {
                    record1.append(record[i].dir)
                    j++
                    if((num == 2)&&(record[i].dir == direction))
                    {
                        dir = record[i].dir
                        return dir
                    }
                }
            }
            
           let judge = Int(rand()) % j
            dir = record1[judge]
        }
        return dir
    }
    
    func LiveOrNot() -> Bool{
        if(status == 1)
        {
          return true
        }
        else
        {
            return false
        }
    }
    
    func EnemyMove(a:[MapNode])
    {
        let dir = GenerateDir(a)
        if(!LiveOrNot())
        {
            return
        }
        if(dir == Direction.UP)
        {
            if(dir != direction)
            {
                AdjustDirection(dir)
            }
            else
            {
               if((Int(self.Tank_Y) <= remider1 - 43)&&(JudgeTankandWall(self.Tank_X, Tank_Y: self.Tank_Y, a:a, dire: Direction.UP)))
               {
                    let judge_X = Int(self.Tank_Y/30)
                    let judge_Y = Int((Int(self.Tank_X) - reminder)/30)
                    a[(judge_X-1)*26+judge_Y].state = 0
                    a[(judge_X-1)*26+judge_Y-1].state = 0
                    a[(judge_X+1)*26+judge_Y].state = 6
                    a[(judge_X+1)*26+judge_Y-1].state = 6
                    self.Tank_Y += 30
                   TankMove(CGPoint(x: self.Tank_X,y: self.Tank_Y))
                }
            }
        }
        else if(dir == Direction.DOWN)
        {
            
            if(dir != self.direction)
            {
                AdjustDirection(dir)
            }
            else
            {
                if((self.Tank_Y >= 40)&&(JudgeTankandWall(self.Tank_X , Tank_Y: self.Tank_Y, a:a, dire: Direction.DOWN)))
                {
                    let judge_X = Int(self.Tank_Y/30)
                    let judge_Y = Int((Int(self.Tank_X) - reminder)/30)
                    a[(judge_X)*26+judge_Y].state = 0
                    a[(judge_X)*26+judge_Y-1].state = 0
                    a[(judge_X-2)*26+judge_Y].state = 6
                    a[(judge_X-2)*26+judge_Y-1].state = 6
                    self.Tank_Y -= 30
                    TankMove(CGPoint(x: self.Tank_X,y: self.Tank_Y))
                }
            }
        }
      else if(dir == Direction.LEFT)
        {
            if(dir != direction)
            {
                AdjustDirection(dir)
            }
            else
            {
                if((Int(self.Tank_X) >= reminder+40) && (JudgeTankandWall(self.Tank_X, Tank_Y: self.Tank_Y, a:a, dire: Direction.LEFT)))
                {
                    let judge_X = Int(self.Tank_Y/30)
                    let judge_Y = Int((Int(self.Tank_X) - reminder)/30)
                    a[(judge_X)*26+judge_Y].state = 0
                    a[(judge_X-1)*26+judge_Y].state = 0
                    a[(judge_X)*26+judge_Y-2].state = 6
                    a[(judge_X-1)*26+judge_Y-2].state = 6
                    self.Tank_X -= 30
                    TankMove(CGPoint(x: self.Tank_X,y: self.Tank_Y))
                }
            }
        }
        else
        {
            if(dir != direction)
            {
                AdjustDirection(dir)
            }
            else
            {
                if((Double(self.Tank_X) <= Double(reminder/4 * 13) - 10)&&(JudgeTankandWall(self.Tank_X, Tank_Y: self.Tank_Y, a:a, dire: Direction.RIGHT)))
                {
                    let judge_X = Int(self.Tank_Y/30)
                    let judge_Y = Int((Int(self.Tank_X) - reminder)/30)
                    a[(judge_X)*26+judge_Y-1].state = 0
                    a[(judge_X-1)*26+judge_Y-1].state = 0
                    a[(judge_X-1)*26+judge_Y+1].state = 6
                    a[(judge_X)*26+judge_Y+1].state = 6
                    self.Tank_X += 30
                    TankMove(CGPoint(x: self.Tank_X,y: self.Tank_Y))
                }
            }
        }
    }
    
    func JudgeTankandWall(Tank_X: CGFloat, Tank_Y: CGFloat, a:[MapNode], dire:Direction)->Bool
    {
        let judge_X = Int(Tank_Y/30)
        let judge_Y = Int((Int(Tank_X)-reminder)/30)
        if(dire == Direction.UP)
        {
            if(judge_X+1>=25 || judge_Y-1<0)
            {
                return false
            }
            else if(a[(judge_X+1)*26+judge_Y-1].state != 0 || a[(judge_X+1)*26+judge_Y].state != 0)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if(dire == Direction.DOWN)
        {
            if(judge_X-2<0 || judge_Y-1<0)
            {
                return false
            }
            else if(a[(judge_X-2)*26+judge_Y-1].state != 0 || a[(judge_X-2)*26+judge_Y].state != 0)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if(dire == Direction.RIGHT)
        {
            if(judge_X-1<0 || judge_Y+1>=26)
            {
                return false
            }
            else if(a[(judge_X)*26+judge_Y+1].state != 0 || a[(judge_X-1)*26+judge_Y+1].state != 0)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            if(judge_X-1<0 || judge_Y-2<0)
            {
                return false
            }
            else if(a[(judge_X)*26+judge_Y-2].state != 0 || a[(judge_X-1)*26+judge_Y-2].state != 0)
            {
                return false
            }
            else
            {
                return true
            }
        }
    }
}