//
//  FightMap.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit


//var Map: Dictionary<Position, Obstacle> = Dictionary<CGPoint, Obstacle>()




class FightMap{
    
    var stage: Int = 0
    
    var scene: NewGameSceneplayer1 = NewGameSceneplayer1()
    
    var obstacleList: ObstacleList = ObstacleList()
    
    init(){
        stage = 1
    }
    
    init(_stage: Int, _scene: NewGameSceneplayer1){
        stage = _stage
        scene = _scene
    }

    
    
    
    func FirstStageMap(){
        
        var i: CGFloat = 0
        for(i = LeftBound.x + 80;i < (LeftBound.x + RightBound.x)/2 - 150; i += Width){
            var brick: Obstacle = Obstacle(_type: OBSTACLE.BRICK, _point: CGPointMake(i, 20))
            var brickNode: ListNode<Obstacle> = ListNode<Obstacle>()
            obstacleList.OBList.appendToTail(brickNode)
            
            scene.addChild(brick.obstacle)
        }
        
    }
    
    
    func SecondStageMap(){
        
    }
    
    func DrawFightMap(){
        
        switch stage{
        case 1:
            FirstStageMap()
            break
        case 2:
            SecondStageMap()
            break
        default:
            break;
        }
        
    }

}
