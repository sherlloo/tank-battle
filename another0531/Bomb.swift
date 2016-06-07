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
                self.point = CGPointMake(_point.x, _point.y + 15)
                self.bombTexture = SKTexture(imageNamed: "upbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.position = point
                break
            case Direction.DOWN:
                self.point = _point
                self.bombTexture = SKTexture(imageNamed: "downbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.position = point
                break
            case Direction.LEFT:
                self.point = CGPointMake(_point.x - 10, _point.y)
                self.bombTexture = SKTexture(imageNamed: "leftbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
                self.bomb.position = point
                break
            case Direction.RIGHT:
                self.point = CGPointMake(_point.x + 20, _point.y)
                self.bombTexture = SKTexture(imageNamed: "rightbomb")
                self.bomb = SKSpriteNode(texture: bombTexture)
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
    
    func bombBoundDetecion()->Bool{
        
        var exceedBound: Bool = false
        
        switch direction{
        case Direction.UP:
            break
        case Direction.DOWN:
            break
        case Direction.LEFT:
            if point.x < LeftBound.x{
                exceedBound = true
            }
            break
        case Direction.RIGHT:
            if point.x > RightBound.x{
                exceedBound = true
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
    
    func BombListMove(){
        
        var bombHead: ListNode<Bomb>? = bombList.head
        
        while bombHead != nil{
            
            /*change the point location*/
            bombHead!.key!.bombMove()
            
            if bombHead!.key!.bombBoundDetecion(){
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







