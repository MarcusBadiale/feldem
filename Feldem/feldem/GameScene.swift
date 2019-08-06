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
    
    var teste = true
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode?
    var player: SKSpriteNode?
    var wall: SKSpriteNode?
    var centerOfSquare0: SKNode?
    var centerOfSquare1: SKNode?
    var centerOfSquare2: SKNode?
    var centerOfSquare3: SKNode?
    var centerOfSquare4: SKNode?
    var centerOfSquare5: SKNode?
    var centerOfSquare6: SKNode?
    var centerOfSquare7: SKNode?
    var centerOfSquare8: SKNode?
    var centerOfSquare9: SKNode?
    var centerOfSquare10: SKNode?
    var centerOfSquare11: SKNode?
    
    var centers = [SKNode]()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        self.player = (self.childNode(withName: "player") as? SKSpriteNode)!
        
        self.centerOfSquare0 = (self.childNode(withName: "centerOfSquare0"))!
        self.centerOfSquare1 = (self.childNode(withName: "centerOfSquare1"))!
        self.centerOfSquare2 = (self.childNode(withName: "centerOfSquare2"))!
        self.centerOfSquare3 = (self.childNode(withName: "centerOfSquare3"))!
        self.centerOfSquare4 = (self.childNode(withName: "centerOfSquare4"))!
        self.centerOfSquare5 = (self.childNode(withName: "centerOfSquare5"))!
        self.centerOfSquare6 = (self.childNode(withName: "centerOfSquare6"))!
        self.centerOfSquare7 = (self.childNode(withName: "centerOfSquare7"))!
        self.centerOfSquare8 = (self.childNode(withName: "centerOfSquare8"))!
        self.centerOfSquare9 = (self.childNode(withName: "centerOfSquare9"))!
        self.centerOfSquare10 = (self.childNode(withName: "centerOfSquare10"))!
        self.centerOfSquare11 = (self.childNode(withName: "centerOfSquare11"))!
        
        centers = [centerOfSquare0, centerOfSquare1, centerOfSquare2, centerOfSquare3, centerOfSquare4, centerOfSquare5, centerOfSquare6, centerOfSquare7, centerOfSquare8, centerOfSquare9, centerOfSquare10, centerOfSquare11] as! [SKNode]
        
        player?.name = "player"
        wall?.name = "wall"
        self.wall = (self.childNode(withName: "wall")as? SKSpriteNode)!
        camera = cameraTeste
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
        
        for node in centers{
            if player!.position.distance(point: node.position) < player!.position.distance(point: cameraTeste!.position){
                cameraTeste?.run(SKAction.move(to: node.position, duration: 0.5))
            }
        }
    }
    
    func stopMoving(player: SKSpriteNode) {
        player.removeAction(forKey: "move")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "wall"{
            stopMoving(player: player!)
            if player!.position.y < wall!.position.y{
                player?.position.y = (player?.position.y)! - 1.0
            }
            
            print("o player bateu com a parede")
        }
        
        if contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "wall"{
            stopMoving(player: player!)
            if player!.position.y < wall!.position.y{
                player?.run(SKAction.moveTo(y: player!.position.y - 5, duration: 0.1))
                print("empurrou")
            }
            print("a parede bateu com o player")
        }
    }
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}

