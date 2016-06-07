//
//  Label.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit

var LeftBound: CGPoint  = CGPointMake(0, 0)
var RightBound: CGPoint = CGPointMake(0, 0)
var UpBound: CGPoint = CGPointMake(0, 0)
var DownBound: CGPoint = CGPointMake(0, 0)

class Button {
    
    let upLabel    = SKLabelNode(text: "Chalkduster")
    let downLabel  = SKLabelNode(text: "Chalkduster")
    let leftLabel  = SKLabelNode(text: "Chalkduster")
    let rightLabel = SKLabelNode(text: "Chalkduster")
    let attackLabel = SKLabelNode(text: "Chalkduster")
    
    let FightViewTexture = SKTexture(imageNamed: "divider")
    var FightViewl = SKSpriteNode()
    
    var FightViewr = SKSpriteNode()
    
    init()
    {
        upLabel.name = "Up"
        upLabel.text = "U"
        upLabel.fontName="MarkerFelt-Thin"
        upLabel.fontSize = 80
        upLabel.fontColor = SKColor.orangeColor()
        
        downLabel.name = "Down"
        downLabel.text = "D"
        downLabel.fontName="MarkerFelt-Thin"
        downLabel.fontSize = 80
        downLabel.fontColor = SKColor.orangeColor()
        
        leftLabel.name = "Left"
        leftLabel.text = "L"
        leftLabel.fontName="MarkerFelt-Thin"
        leftLabel.fontSize = 80
        leftLabel.fontColor = SKColor.orangeColor()
        
        rightLabel.name = "Right"
        rightLabel.text = "R"
        rightLabel.fontName="MarkerFelt-Thin"
        rightLabel.fontSize = 80
        rightLabel.fontColor = SKColor.orangeColor()
        
        attackLabel.name = "Attack"
        attackLabel.text = "A"
        attackLabel.fontName="MarkerFelt-Thin"
        attackLabel.fontSize = 120
        attackLabel.fontColor = SKColor.orangeColor()
        
        FightViewl = SKSpriteNode(texture: FightViewTexture)
        FightViewl.setScale(2)
        
        FightViewr = SKSpriteNode(texture: FightViewTexture)
        FightViewr.setScale(2)
        
    }
    
    func SetButtonPosition(X:CGFloat,Y:CGFloat)
    {
        upLabel.position = CGPointMake(X, Y)
        
        downLabel.position = CGPointMake(X, Y - 90)
        
        leftLabel.position = CGPointMake(X - 90, Y - 90)
        
        rightLabel.position = CGPointMake(X + 90, Y - 90)
        
        attackLabel.position = CGPointMake((X - 20) * 6.5 + 120, Y - 90)
        
        LeftBound = CGPointMake((X - 20)*2 - 80, Y)
        FightViewl.position = CGPointMake((X - 20)*2, Y)
        
        RightBound = CGPointMake((X - 20)*6.5 + 80, Y)
        FightViewr.position = CGPointMake((X - 20)*6.5, Y)
        
        
    }
    
}
