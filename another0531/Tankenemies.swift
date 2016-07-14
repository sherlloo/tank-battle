//
//  Tankenemies.swift
//  another0531
//
//  Created by Apple on 16/7/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

class Tankenemies {
    
    var enemy1 = TankSingle6()
    var enemy2 = TankSingle6()
    var enemy3 = TankSingle6()
    var enemy4 = TankSingle6()
    
    var count = 4
    
    init()
    {
        
    }
    
    func SetEnemiesPosition(a:CGFloat,b:CGFloat,c:CGFloat,d:CGFloat)
    {
        enemy1.setTankPosition(a, b:b, c:c,d:d)
        enemy2.setTankPosition(a + 240.0, b: b, c:c,d:d)
        enemy3.setTankPosition(a + 480.0, b: b, c:c,d:d)
        enemy4.setTankPosition(a + 720.0, b: b, c:c,d:d)
    }
    
    func EnemiesMove(a:[MapNode])
    {
        enemy1.EnemyMove(a)
        enemy2.EnemyMove(a)
        enemy3.EnemyMove(a)
        enemy4.EnemyMove(a)
    }
    
    func BringBackToLife(enemy:TankSingle6)
    {
        enemy.status = 1
        enemy.direction = Direction.DOWN
        enemy.TankEnemyDown.hidden = false
        enemy.TankEnemyLeft.hidden = true
        enemy.TankEnemyRight.hidden = true
        enemy.TankEnemyUp.hidden = true
    }
}