//
//  List.swift
//  another0531
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import Foundation
import SpriteKit


class ListNode{
    
    var bomb: Bomb = Bomb()
    
    var prev: ListNode?
    var next: ListNode?
    
    init(){
        self.prev = nil
        self.next = nil
    }
    
    init(_bomb: Bomb){
        self.bomb = _bomb
        self.prev = nil
        self.next = nil
    }
    
};

class List{
    var head: ListNode?
    var tail: ListNode?
    
    init(){
        self.head = nil
        self.tail = nil
    }
    
    func appendToTail(node: ListNode){
        if tail == nil{
            tail = node
            head = tail
        }
        else{
            tail!.next = node
            node.prev = tail
            
            tail = node
        }
    }
    
    func appendToHead(node: ListNode){
        if head == nil{
            head = node
            tail = head
        }
        else{
            head!.prev = node
            node.next = head
            
            head = node
        }
    }
    
    /*没有释放子弹所申请的资源*/
    func remove(node: ListNode){
        
        /*should delete the bomb, not hiden*/
        node.bomb.bomb.hidden = true
        
        if node.prev == nil && node.next == nil{
            head = nil
            tail = nil
        }
        else if node.prev == nil{
            head = node.next;
            head?.prev = nil
        }
        else if node.next == nil{
            tail = node.prev
            tail?.next = nil
        }
        else{
            node.prev?.next = node.next
            node.next?.prev = node.prev
        }
    }
    
    func BombListMove(){
        
        var bombHead: ListNode? = head
        
        while bombHead != nil{
            
            /*change the point location*/
            bombHead!.bomb.bombMove()
            
            if bombHead!.bomb.bombBoundDetecion(){
                /*exceed bound*/
                let bombtemp: ListNode! = bombHead!
                bombHead = bombHead?.next
                self.remove(bombtemp!)
            }
            else{
                bombHead!.bomb.bomb.runAction(SKAction.moveTo((bombHead?.bomb.point)!, duration: 0.1))
                bombHead = bombHead?.next
            }
        }
        
    }
}

