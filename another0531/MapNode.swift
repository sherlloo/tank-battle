//
//  MapNode.swift
//  another0531
//
//  Created by Apple on 16/7/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

public class MapNode{
    
    var state = 0
    var Wall = SKSpriteNode()
    
    init()
    {

    }
}

public class RecordDirection {
    
    var record:Bool = false
    var dir = Direction.UP
    
    init()
    {
        
    }
}