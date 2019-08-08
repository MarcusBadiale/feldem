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
    
    var feldem: Character!
    
    var ghost: Character!
    var ghost2: Character!
    var ghost3: Character!
    var smokeGhost: Character!
    
    var timer = 0
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode!
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
        wall?.name = "wall"
        self.wall = (self.childNode(withName: "wall")as? SKSpriteNode)!
        wall?.physicsBody?.categoryBitMask = 2
        wall?.physicsBody?.collisionBitMask = 2
        camera = cameraTeste
        
        // Create feldem
        let characterSize = CGSize(width: frame.size.width , height: frame.size.height)
        print(characterSize)
        feldem = Character(name: "feldem", speed: 150, size: characterSize, characterPosition: cameraTeste.position)
        ghost = Character(name: "ghost", speed: 200, size: characterSize, characterPosition: CGPoint(x: -25, y: 207))
        ghost2 = Character(name: "ghost", speed: 225, size: characterSize, characterPosition: CGPoint(x: -50, y: 207))
        ghost3 = Character(name: "ghost", speed: 250, size: characterSize, characterPosition: CGPoint(x: -75, y: 207))
        smokeGhost = Character(name: "smokeGhost", speed: 275, size: characterSize, characterPosition: CGPoint(x: -100, y: 207))
        
        
        addChild(feldem)
        addChild(ghost)
        addChild(ghost2)
        addChild(ghost3)
        addChild(smokeGhost)
    
        playMusic()
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in centers{
            if feldem.position.distance(point: node.position) < feldem.position.distance(point: cameraTeste!.position){
                cameraTeste?.run(SKAction.move(to: node.position, duration: 0.5))
            }
        }
        
        if !feldem.isMoving{
            timer += 1
            if timer == 390{
                feldem.updateCharacterState(to: .feldemLayingDown)
                feldem.animateCharacter(state: .feldemLayingDown, timePerFrame: 1.5)
            }
            if timer == 800{
                feldem.updateCharacterState(to: .feldemSleeping)
                feldem.animateCharacter(state: .feldemSleeping, timePerFrame: 1.5)
                
            }
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = (touch?.location(in: self))!
        let feldemDirection = feldem.calculateWalkingDirection(touchLocation: location)
        feldem.updateCharacterState(to: feldemDirection)
        feldem.moveCharacter(to: location)
        timer = 0
    }
    
    // MARK: - Physics Functions
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "feldem" && contact.bodyB.node?.name == "wall"{
            feldem.characterMoveEnded()
            if feldem.position.y < wall!.position.y{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "wall"{
            feldem.characterMoveEnded()
            if feldem.position.y < wall!.position.y{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
    }
}

