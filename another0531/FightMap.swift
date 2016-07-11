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
    
    //var scene: NewGameSceneplayer1 = NewGameSceneplayer1()
    
    var obstacleList: ObstacleList = ObstacleList()
    
    var map = [[Int]](count: 12, repeatedValue: [Int](count: 13, repeatedValue: 0))  //0 for nothing, 1 for brick, 2 for slab, 3 for river, 4 for grass and 5 for boss.
    
    init(){
        stage = 1
        for var i=0;i<12;i++
        {
            for var j=0;j<13;j++
            {
                map[i][j] = 0
            }
        }
    }
    
//    init(_stage: Int, _scene: NewGameSceneplayer1){
//        stage = _stage
//        scene = _scene
//    }
//    
    func FirstStageMap(){
        map[0][5]=1;
        map[0][6]=5;
        map[0][7]=1;
        for var j=5;j<8;j++
        {
            map[1][j]=1
        }
        for var j=1;j<12;j++
        {
            map[4][j] = 1
        }
        for var j=4;j<9;j++
        {
            map[6][j] = 2
        }
        for var j=0;j<13;j++
        {
            map[10][j] = 1
        }
        map[10][6] = 0
                
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
