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

//struct mapNode {
//    state:Int
//    
//}


class FightMap{
    
    var stage: Int = 0
    
    //var scene: NewGameSceneplayer1 = NewGameSceneplayer1()
    
    var obstacleList: ObstacleList = ObstacleList()
    
    var map1 = Array<MapNode>()
    //(count: 25, repeatedValue: [MapNode](count: 26, repeatedValue: 0))  //0 for nothing, 1 for brick, 2 for slab, 3 for river, 4 for grass and 5 for boss.
    
    init(){
        stage = 1
        for var i=0;i<25;i++
        {
            for var j=0;j<26;j++
            {
                let mapnode = MapNode()
                map1.append(mapnode)
            }
        }
    }
    
//    init(_stage: Int, _scene: NewGameSceneplayer1){
//        stage = _stage
//        scene = _scene
//    }
//    
    func FirstStageMap(){
        map1[0+11].state=1
        map1[0+12].state=5
        map1[0+14].state=1
        map1[0+10].state=9
        map1[0+9].state=9
        map1[1*26+9].state=9
        map1[1*26+10].state=9
        map1[1*26+11].state=1
        map1[1*26+14].state=1
        for var j=11;j<15;j++
        {
            map1[2*26+j].state=1
        }
        for var j=2;j<24;j++
        {
            map1[8*26+j].state = 1
            map1[9*26+j].state = 1
        }
        for var j=8;j<17;j++
        {
            map1[12*26+j].state = 2
            map1[13*26+j].state = 2
        }
        for var j=0;j<26;j++
        {
            map1[21*26 + j].state = 1
            map1[22*26 + j].state = 1
        }
        map1[21*26+12].state=0
        map1[21*26+13].state=0
        map1[22*26+12].state = 0
        map1[22*26+13].state = 0
        map1[23*26+0].state = 6
        map1[23*26+1].state = 6
        map1[23*26+9].state = 6
        map1[23*26+8].state = 6
        map1[23*26+16].state = 6
        map1[23*26+17].state = 6
        map1[23*26+24].state = 6
        map1[23*26+25].state = 6
        map1[24*26+0].state = 6
        map1[24*26+1].state = 6
        map1[24*26+9].state = 6
        map1[24*26+8].state = 6
        map1[24*26+16].state = 6
        map1[24*26+17].state = 6
        map1[24*26+24].state = 6
        map1[24*26+25].state = 6
    }
    
    
    func SecondStageMap(){
        
    }
    
    func DrawFightMap(){
        
        switch self.stage{
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
