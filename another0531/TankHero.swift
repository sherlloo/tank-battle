//
//  TankHero.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

//
//  TankHero.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

class TankHero {
    
    var TankHeroUpTexture = SKTexture(imageNamed: "TankUp")
    var TankHeroUp = SKSpriteNode()
    
    var TankHeroDownTexture = SKTexture(imageNamed: "TankDown")
    var TankHeroDown = SKSpriteNode()
    
    var TankHeroLeftTexture = SKTexture(imageNamed: "TankLeft")
    var TankHeroLeft = SKSpriteNode()
    
    var TankHeroRightTexture = SKTexture(imageNamed: "TankRight")
    var TankHeroRight = SKSpriteNode()
    
    var direction = Direction.UP
    
    var TankRect: CGRect = CGRect()
    
    init()
    {
        direction = Direction.UP
        
        TankHeroUp = SKSpriteNode(texture:TankHeroUpTexture)
        TankHeroUp.size = CGSizeMake(60, 60)
        TankHeroUp.name = "TankHeroUp"
        TankHeroUp.hidden = false
        
        TankHeroDown = SKSpriteNode(texture:TankHeroDownTexture)
        TankHeroDown.size = CGSizeMake(60, 60)
        TankHeroDown.name = "TankHeroDown"
        TankHeroDown.hidden = true
        
        TankHeroLeft = SKSpriteNode(texture:TankHeroLeftTexture)
        TankHeroLeft.size = CGSizeMake(60, 60)
        TankHeroLeft.name = "TankHeroLeft"
        TankHeroLeft.hidden = true
        
        TankHeroRight = SKSpriteNode(texture:TankHeroRightTexture)
        TankHeroRight.size = CGSizeMake(60, 60)
        TankHeroRight.name = "TankHeroRight"
        TankHeroRight.hidden = true
    }
    
    func SetTankPosition (Tank_X: CGFloat, Tank_Y: CGFloat)
    {
        
        TankHeroUp.position = CGPointMake(Tank_X, Tank_Y)
        
        TankHeroDown.position = CGPointMake(Tank_X, Tank_Y)
        
        TankHeroLeft.position = CGPointMake(Tank_X, Tank_Y)
        
        TankHeroRight.position = CGPointMake(Tank_X, Tank_Y)
        
        TankRect.origin = CGPointMake(Tank_X, Tank_Y)
        
        TankRect.size = CGSizeMake(24, 24)
    }
    
    func AdjustDirection(Direct:Direction)
    {
        if(Direct == Direction.UP)
        {
            TankHeroDown.hidden = true
            TankHeroLeft.hidden = true
            TankHeroRight.hidden = true
            TankHeroUp.hidden = false
            direction = Direction.UP
            
        }
        else if(Direct == Direction.DOWN)
        {
            TankHeroDown.hidden = false
            TankHeroLeft.hidden = true
            TankHeroRight.hidden = true
            TankHeroUp.hidden = true
            direction = Direction.DOWN
        }
        else if(Direct == Direction.LEFT)
        {
            TankHeroDown.hidden = true
            TankHeroLeft.hidden = false
            TankHeroRight.hidden = true
            TankHeroUp.hidden = true
            direction = Direction.LEFT
        }
        else
        {
            TankHeroDown.hidden = true
            TankHeroLeft.hidden = true
            TankHeroRight.hidden = false
            TankHeroUp.hidden = true
            direction = Direction.RIGHT
        }
    }
    
    func TankMove(location:CGPoint)
    {
        
        TankHeroUp.runAction(SKAction.moveTo(location, duration: 0.1))
        TankHeroDown.runAction(SKAction.moveTo(location, duration: 0.1))
        TankHeroLeft.runAction(SKAction.moveTo(location, duration: 0.1))
        TankHeroRight.runAction(SKAction.moveTo(location, duration: 0.1))
        
    }
    
    func JudgeTankandWall(Tank_X: CGFloat, Tank_Y: CGFloat, a:[[Int]], dire:Direction)->Bool
    {
        let judge_X = Int(Tank_Y/60)
        let judge_Y = Int(Tank_X/60)
        if(dire == Direction.UP)
        {
            if(Int(Tank_Y)%60==0)
            {
                return true
            }
            else
            {
             if(judge_X+1>=12)
             {
                return false
             }
              if(a[judge_X+1][judge_Y] != 0)
              {
                  return false
              }
              else
              {
                  if(Int(Tank_X)%60 == 0)
                  {
                    if(a[judge_X+1][judge_Y-1] != 0)
                    {
                        return false
                    }
                    return true
                  }
                  return true
                }
            }

        }
        else if(dire == Direction.DOWN)
        {
            if(Int(Tank_Y)%60==0)
            {
                return true
            }
            else
            {
                if(a[judge_X-1][judge_Y] != 0)
                {
                    return false
                }
                else
                {
                    if(Int(Tank_X)%60 == 0)
                    {
                        if(a[judge_X-1][judge_Y-1] != 0)
                        {
                           return false
                        }
                        return true
                    }
                    return true
                }
            }
        }
        else if(dire == Direction.RIGHT)
        {
            if(Int(Tank_X)%60==0)
            {
                return true
            }
            else
            {
                if(judge_Y+1>=13)
                {
                    return false
                }
                else
                {
                    if(a[judge_X][judge_Y+1] != 0)
                    {
                        return false
                    }
                    else
                    {
                        if(Int(Tank_Y)%60 == 0)
                        {
                           if(a[judge_X-1][judge_Y+1] != 0)
                           {
                             return false
                            }
                            return true
                        }
                        return true
                    }
                }
            }
        }
        else
        {
            if(Int(Tank_X)%60==0)
            {
                return true
            }
            else
            {
                if(judge_Y-1<0)
                {
                    return false
                }
                else
                {
                    if(a[judge_X][judge_Y-1] != 0)
                    {
                        return false
                    }
                    else
                    {
                        if(Int(Tank_Y)%60 == 0)
                        {
                            if(a[judge_X-1][judge_Y-1] != 0)
                            {
                                return false
                            }
                            return true
                        }
                        return true
                    }
                }
            }
        }
    }
}
