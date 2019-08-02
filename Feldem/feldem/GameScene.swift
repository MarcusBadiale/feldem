//
//  GameScene.swift
//  temporary Game
//
//  Created by Marcus Vinicius Vieira Badiale on 24/07/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode?
    
    override func didMove(to view: SKView) {
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        camera = cameraTeste
        
        if let background = self.background{
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let positionInScene = touch?.location(in: self)

        cameraTeste?.position.x += 10

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
