//
//  GameScene.swift
//  temporary Game
//
//  Created by Marcus Vinicius Vieira Badiale on 24/07/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode?
    var player: SKSpriteNode?
    var wall: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        self.player = (self.childNode(withName: "player") as? SKSpriteNode)!
        player?.name = "player"
        wall?.name = "wall"
        self.wall = (self.childNode(withName: "wall")as? SKSpriteNode)!
        camera = cameraTeste
        
        if let background = self.background{
            background.anchorPoint = CGPoint(x: 0.5, y: 0.12)
        }
        
//        if let wall = self.wall{
//            wall.physicsBody = .
//        }
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
        
        let move = SKAction.move(to: positionInScene!, duration: 0.5)
        
        player?.run(move, withKey: "move")

//        Remover action de mover quando colidir com algo
        
//        player?.removeAction(forKey: "move")
        
        
        
        
//        cameraTeste?.position.x += 10
        
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
        
        if (player?.position.y)! > ((cameraTeste?.position.y)! + 210) {
            cameraTeste?.run(SKAction.move(to: CGPoint(x: (cameraTeste?.position.x)!, y: (cameraTeste?.position.y)! + 414), duration: 0.5))
        }
        if (player?.position.y)! < ((cameraTeste?.position.y)! - 210) {
            cameraTeste?.run(SKAction.move(to: CGPoint(x: (cameraTeste?.position.x)!, y: (cameraTeste?.position.y)! - 414), duration: 0.5))
        }
        if (player?.position.x)! > ((cameraTeste?.position.x)! + 210) {
            cameraTeste?.run(SKAction.move(to: CGPoint(x: (cameraTeste?.position.x)! + 414, y: (cameraTeste?.position.y)!), duration: 0.5))
        }
        if (player?.position.x)! < ((cameraTeste?.position.x)! - 210) {
            cameraTeste?.run(SKAction.move(to: CGPoint(x: (cameraTeste?.position.x)! - 414, y: (cameraTeste?.position.y)!), duration: 0.5))
        }
        
    }
    
    func stopMoving(player: SKSpriteNode) {
        player.removeAction(forKey: "move")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "wall"{
            stopMoving(player: player!)
        }
        
        if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "wall"{
            stopMoving(player: player!)
        }
    }

}
