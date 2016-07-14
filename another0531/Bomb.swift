//
//  Bomb.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

class Bomb{
    var direction: Direction = Direction.UP
    var point: CGPoint = CGPointMake(0, 0)
    var bombTexture = SKTexture()
    var bomb = SKSpriteNode()
    
    init(){
        /*not do anything*/
    }
    
    init(_dir: Direction, _point: CGPoint){
        self.direction = _dir
//        self.point = _point
        switch direction{
            case Direction.UP:
                self.point = CGPointMake(_point.x, _point.y + 30)
                self.bombTexture = SKTexture(imageNamed: "upbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.size = CGSizeMake(10, 20)
                self.bomb.position = point
                break
            case Direction.DOWN:
                self.point = CGPointMake(_point.x, _point.y - 30)
                self.bombTexture = SKTexture(imageNamed: "downbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.size = CGSizeMake(10, 20)
                self.bomb.position = point
                break
            case Direction.LEFT:
                self.point = CGPointMake(_point.x - 30, _point.y)
                self.bombTexture = SKTexture(imageNamed: "leftbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.size = CGSizeMake(20, 10)
                self.bomb.position = point
                break
            case Direction.RIGHT:
                self.point = CGPointMake(_point.x + 30, _point.y)
                self.bombTexture = SKTexture(imageNamed: "rightbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.size = CGSizeMake(20, 10)
                self.bomb.position = point
                break
        }
    }
    
    func bombMove(){
        
        switch direction{
        case Direction.UP:
            self.point.y += 15
            break
        case Direction.DOWN:
            self.point.y -= 15
            break
        case Direction.LEFT:
            self.point.x -= 15
            break
        case Direction.RIGHT:
            self.point.x += 15
            break
        }

    }
    
    func bombBoundDetecion(var a:[MapNode],b:CGFloat)->Bool{
        
        var exceedBound: Bool = false
        
        var judge_X = Int((point.y-30-5)/30)
        var judge_Y = Int(Int(point.x-b)/30)
        
        switch direction{
        case Direction.UP:
            judge_X = Int((point.y-30-5)/30)
            if(point.y % 30 != 0)
            {
                exceedBound = false
            }
            else if(judge_Y - 1<0 || judge_X+1 >= 25)
            {
                exceedBound = true
            }
            else if(a[(judge_X+1)*26+judge_Y].state != 0 || a[(judge_X+1)*26+judge_Y-1].state != 0)
            {
                exceedBound = true
                if(a[(judge_X+1)*26+judge_Y].state == 1)
                {
                    a[(judge_X+1)*26+judge_Y].state = 0
                    a[(judge_X+1)*26+judge_Y].Wall.hidden = true
                    if(a[(judge_X+1)*26+judge_Y-1].state == 1)
                    {
                        a[(judge_X+1)*26+judge_Y-1].state = 0
                        a[(judge_X+1)*26+judge_Y-1].Wall.hidden = true
                    }
                }
                else
                {
                    if(a[(judge_X+1)*26+judge_Y-1].state == 1)
                    {
                        a[(judge_X+1)*26+judge_Y-1].state = 0
                        a[(judge_X+1)*26+judge_Y-1].Wall.hidden = true
                    }
                    else if(a[(judge_X+1)*26+judge_Y].state == 5 || a[(judge_X+1)*26+judge_Y-1].state == 5)
                    {
                        WinOrNot = 0
                    }
                    else if(a[(judge_X+1)*26+judge_Y].state == 6 || a[(judge_X+1)*26+judge_Y-1].state == 6)
                    {
                        pointx = judge_X+2
                        pointy = judge_Y
                        hit = 1
                    }
               }
            }
            else
            {
              exceedBound = false
            }
            break
        case Direction.DOWN:
            judge_X = Int((point.y+30+30)/30)
            if(point.y % 30 != 0)
            {
                exceedBound = false
            }
            else if(judge_Y - 1<0 || judge_X-2 < 0)
            {
                exceedBound = true
            }
            else if(a[(judge_X-2)*26+judge_Y].state != 0 || a[(judge_X-2)*26+judge_Y-1].state != 0)
            {
                exceedBound = true
                if(a[(judge_X-2)*26+judge_Y].state == 1)
                {
                    a[(judge_X-2)*26+judge_Y].state = 0
                    a[(judge_X-2)*26+judge_Y].Wall.hidden = true
                    if(a[(judge_X-2)*26+judge_Y-1].state == 1)
                    {
                        a[(judge_X-2)*26+judge_Y-1].state = 0
                        a[(judge_X-2)*26+judge_Y-1].Wall.hidden = true
                    }
                }
                else
                {
                    if(a[(judge_X-2)*26+judge_Y-1].state == 1)
                    {
                        a[(judge_X-2)*26+judge_Y-1].state = 0
                        a[(judge_X-2)*26+judge_Y-1].Wall.hidden = true
                    }
                    else if(a[(judge_X-2)*26+judge_Y].state == 5 || a[(judge_X-2)*26+judge_Y-1].state == 5)
                    {
                        WinOrNot = 0
                    }
                    else if(a[(judge_X-2)*26+judge_Y].state == 6 || a[(judge_X-2)*26+judge_Y-1].state == 6)
                    {
                        pointx = judge_X-2
                        pointy = judge_Y
                        hit = 1
                    }
                }
            }
            else
            {
                exceedBound = false
            }
            break
        case Direction.LEFT:
            judge_X = Int(point.y/30)
            judge_Y = Int(Int(point.x-b+60)/30)
            if point.x < LeftBound.x{
                exceedBound = true
            }
            else if((point.x-b)%30 != 0)
            {
                exceedBound = false
            }
            else if(judge_X-1<0 || judge_Y-2<0)
            {
                exceedBound = true
            }
            else if(a[judge_X*26+judge_Y-2].state != 0 || a[(judge_X-1)*26+judge_Y-2].state != 0)
            {
                exceedBound = true
                if(a[judge_X*26+judge_Y-2].state == 1)
                {
                    a[judge_X*26+judge_Y-2].state = 0
                    a[judge_X*26+judge_Y-2].Wall.hidden = true
                    if(a[(judge_X-1)*26+judge_Y-2].state == 1)
                    {
                        a[(judge_X-1)*26+judge_Y-2].state = 0
                        a[(judge_X-1)*26+judge_Y-2].Wall.hidden = true
                    }
                }
                else
                {
                    if(a[(judge_X-1)*26+judge_Y-2].state == 1)
                    {
                        a[(judge_X-1)*26+judge_Y-2].state = 0
                        a[(judge_X-1)*26+judge_Y-2].Wall.hidden = true
                    }
                    else if(a[(judge_X-1)*26+judge_Y-2].state == 5 || a[(judge_X)*26+judge_Y-2].state == 5)
                    {
                        WinOrNot = 0
                    }
                    else if(a[(judge_X-1)*26+judge_Y-2].state == 6 || a[(judge_X)*26+judge_Y-2].state == 6)
                    {
                        hit = 1
                        pointx = judge_X
                        pointy = judge_Y-2
                    }

                }
            }
            else
            {
                exceedBound = false
            }
            break
        case Direction.RIGHT:
            judge_X = Int(point.y/30)
            judge_Y = Int(Int(point.x-b-60)/30)
            if point.x < LeftBound.x{
                exceedBound = true
            }
            else if((point.x-b)%30 != 0)
            {
                exceedBound = false
            }
            else if(judge_X-1<0 || judge_Y+1>=26)
            {
                exceedBound = true
            }
            else if(a[judge_X*26+judge_Y+1].state != 0 || a[(judge_X-1)*26+judge_Y+1].state != 0)
            {
                exceedBound = true
                if(a[judge_X*26+judge_Y+1].state == 1)
                {
                    a[judge_X*26+judge_Y+1].state = 0
                    a[judge_X*26+judge_Y+1].Wall.hidden = true
                    if(a[(judge_X-1)*26+judge_Y+1].state == 1)
                    {
                        a[(judge_X-1)*26+judge_Y+1].state = 0
                        a[(judge_X-1)*26+judge_Y+1].Wall.hidden = true
                    }
                }
                else
                {
                    if(a[(judge_X-1)*26+judge_Y+1].state == 1)
                    {
                        a[(judge_X-1)*26+judge_Y+1].state = 0
                        a[(judge_X-1)*26+judge_Y+1].Wall.hidden = true
                    }
                    else if(a[judge_X*26+judge_Y+1].state == 5 || a[(judge_X-1)*26+judge_Y+1].state == 5)
                    {
                        WinOrNot = 0
                    }
                    else if(a[judge_X*26+judge_Y+1].state == 6 || a[(judge_X-1)*26+judge_Y+1].state == 6)
                    {
                        hit = 1
                        pointx = judge_X
                        pointy = judge_Y+2
                    }
                }
            }
            else
            {
                exceedBound = false
            }

            break
        }
        return exceedBound
    }
    
}


func == (left: Bomb, right: Bomb) -> Bool{
    if left.bomb == right.bomb{
        return true
    }
    else{
        return false
    }
}

func != (left: Bomb, right: Bomb) -> Bool{
    if left.bomb == right.bomb{
        return false
    }
    else{
        return true
    }
}

class BombList{
    var bombList = List<Bomb>()
    
    init(){
        
    }
    
    func BombListMove(a:[MapNode], b:CGFloat){
        
        var bombHead: ListNode<Bomb>? = bombList.head
        
        while bombHead != nil{
            
            /*change the point location*/
            bombHead!.key!.bombMove()
            
            if bombHead!.key!.bombBoundDetecion(a,b: b){
                /*exceed bound*/
                let bombtemp: ListNode<Bomb>! = bombHead!
                bombHead = bombHead?.next
                
                bombtemp.key!.bomb.hidden = true
                bombList.remove(bombtemp!)
            }
            else{
                bombHead!.key!.bomb.runAction(SKAction.moveTo((bombHead?.key!.point)!, duration: 0.1))
                bombHead = bombHead?.next
            }
        }
        
    }
    
    
}







