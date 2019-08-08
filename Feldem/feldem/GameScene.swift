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
    var id = 1
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode?
    var gate1: SKSpriteNode?
    var gate2: SKSpriteNode?
    var gate3: SKSpriteNode?
    var gate4: SKSpriteNode?
    var tree: SKSpriteNode?
    var portalLight1: SKSpriteNode?
    var portalLight2: SKSpriteNode?
    
    var stump: SKSpriteNode?
    var lake: SKSpriteNode?
    var lake1: SKSpriteNode?
    var lake2: SKSpriteNode?
    var lake3: SKSpriteNode?
    
    var walls = [SKSpriteNode]()
    var darkwalls = [SKSpriteNode]()
    var centers = [SKNode]()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        self.gate1 = (self.childNode(withName: "gate1") as? SKSpriteNode)!
        self.gate2 = (self.childNode(withName: "gate2") as? SKSpriteNode)!
        self.tree = (self.childNode(withName: "tree")as? SKSpriteNode)!
        self.portalLight1 = (self.childNode(withName: "portalLight1")as? SKSpriteNode)!
        self.portalLight2 = (self.childNode(withName: "portalLight2")as? SKSpriteNode)!
        
        self.stump = (self.childNode(withName: "stump")as? SKSpriteNode)!
        self.lake = (self.childNode(withName: "lake")as? SKSpriteNode)!
        self.lake1 = (self.childNode(withName: "lake1")as? SKSpriteNode)!
        self.lake2 = (self.childNode(withName: "lake2")as? SKSpriteNode)!
        self.lake3 = (self.childNode(withName: "lake3")as? SKSpriteNode)!
        
        centers = children.filter({ $0.name?.contains("centerOfSquare") ?? false })
        walls = children.filter({ $0.name?.contains("wall") ?? false }) as! [SKSpriteNode]
        darkwalls = children.filter({ $0.name?.contains("Dark") ?? false }) as! [SKSpriteNode]
        
        for wall in walls{
            wall.name = "wall"
            wall.physicsBody?.categoryBitMask = 2
            wall.physicsBody?.collisionBitMask = 2
        }
        
        for wall in darkwalls{
            wall.name = "wall"
            wall.physicsBody?.categoryBitMask = 2
            wall.physicsBody?.collisionBitMask = 2
        }
        
        stump?.name = "wall"
        lake?.name = "wall"
        lake1?.name = "wall"
        lake2?.name = "wall"
        
        gate1?.name = "gate"
        gate2?.name = "gate"
        
        camera = cameraTeste
        
        // Create feldem
        let characterSize = CGSize(width: frame.size.width , height: frame.size.height)
        print(characterSize)
        feldem = Character(name: "feldem", speed: 150, size: characterSize, characterPosition: cameraTeste!.position)
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
        
        
        if feldem.position.y >= (portalLight1!.position.y - portalLight1!.size.height/2){
            if feldem.position.x < (portalLight1!.position.x + portalLight1!.size.width/2) && feldem.position.x > (portalLight1!.position.x - portalLight1!.size.width/2){
                feldem.position.x = portalLight2!.position.x
                feldem.position.y = (portalLight2?.position.y)! - 100
                cameraTeste?.position = centers[6].position
            }
        }
        
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
            if feldem.position.y < (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
            
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "wall"{
            feldem.characterMoveEnded()
            if feldem.position.y < (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "gate"{
            feldem.characterMoveEnded()
            if feldem.position.y < (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
        }
        
        if contact.bodyA.node?.name == "feldem" && contact.bodyB.node?.name == "gate"{
            feldem.characterMoveEnded()
            if feldem.position.y < (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 10, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 10, duration: 0.1))
            }
        }
    }
}

