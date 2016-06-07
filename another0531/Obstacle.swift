//
//  Obstacle.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

enum OBSTACLE{
    case BRICK, SLAB, GRASS, RIVER, BLANK
};

var Width: CGFloat = 60

class Obstacle{
    
    var type = OBSTACLE.BLANK
    
    var OBPoint: CGPoint = CGPoint()
    var OBRect: CGRect = CGRect()
    var obstacleTexture = SKTexture()
    var obstacle = SKSpriteNode()
    
    init(){
        
    }
    
    init(_type: OBSTACLE, _point: CGPoint){
        
        type = _type
        OBPoint = _point
        OBRect.origin = _point
        OBRect.size = CGSizeMake(60, 60)
        
        switch type{
        case OBSTACLE.BLANK:
            break
        case OBSTACLE.BRICK:
            obstacleTexture = SKTexture(imageNamed: "Brick")
            break
        case OBSTACLE.SLAB:
            obstacleTexture = SKTexture(imageNamed: "Slab")
            break
        case OBSTACLE.GRASS:
            obstacleTexture = SKTexture(imageNamed: "Grass")
            break
        case OBSTACLE.RIVER:
            obstacleTexture = SKTexture(imageNamed: "River")
        
        }
        
        obstacle = SKSpriteNode(texture: obstacleTexture)
        obstacle.size = CGSizeMake(60, 60)
        obstacle.position = OBPoint
        
    }
    
}

class ObstacleList{
    var OBList = List<Obstacle>()
    
    init(){
        
    }
    
    func AttackDetection(){
        
    }
    
}