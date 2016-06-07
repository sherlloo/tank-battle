//
//  FightMap.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation

class FightMap{
    
    var stage: Int = 0
    
    init(){
        stage = 1
    }
    
    init(_stage: Int){
        stage = _stage
    }

    
    
    
    func FirstStageMap(){
        
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
