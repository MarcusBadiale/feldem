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
    
enum WalkingDirection {
        case up, down, left, right, upperRight, upperLeft, downLeft, downRight, standingStill, layingDown, sleeping
        
        var walkingDirectionName: String {
            switch self {
            case .left:
                return "walkingLeft"
            case .right:
                return "walkingRight"
            case .up:
                return "walkingUp"
            case .down:
                return "walkingDown"
            case .downLeft:
                return "walkingDownLeft"
            case .downRight:
                return "walkingDownRight"
            case .upperLeft:
                return "walkingUpperLeft"
            case .upperRight:
                return "walkingUpperRight"
            case .standingStill:
                return "standingStill"
            case .layingDown:
                return "layingDown"
            case .sleeping:
                return "sleeping"
            }
        }
    }
    
    var isMoving = false
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
    var wall1: SKSpriteNode?
    var wall2: SKSpriteNode?
    var wall3: SKSpriteNode?
    var wall4: SKSpriteNode?
    var wall5: SKSpriteNode?
    var wall6: SKSpriteNode?
    var wall7: SKSpriteNode?
    var wall8: SKSpriteNode?
    var wall9: SKSpriteNode?
    var wall10: SKSpriteNode?
    var wall11: SKSpriteNode?
    var wall12: SKSpriteNode?
    var wall13: SKSpriteNode?
    var wall14: SKSpriteNode?
    var wall15: SKSpriteNode?
    var wall16: SKSpriteNode?
    var wall17: SKSpriteNode?
    var wall18: SKSpriteNode?
    var wall19: SKSpriteNode?
    var wall20: SKSpriteNode?
    var wall21: SKSpriteNode?
    var wall22: SKSpriteNode?
    var wall23: SKSpriteNode?
    var wall24: SKSpriteNode?
    var wall25: SKSpriteNode?
    var wall26: SKSpriteNode?
    var wall27: SKSpriteNode?
    var wall28: SKSpriteNode?
    var wall29: SKSpriteNode?
    var wall30: SKSpriteNode?
    var wall31: SKSpriteNode?
    var wall32: SKSpriteNode?
    var wall33: SKSpriteNode?
    var wall34: SKSpriteNode?
    var wall35: SKSpriteNode?
    
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
    
    var walls = [SKSpriteNode]()
    var centers = [SKNode]()
    
    private var feldem = SKSpriteNode()
    private var feldemWalkingFrames: [SKTexture] = []
    
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
        self.wall1 = (self.childNode(withName: "wall1")as? SKSpriteNode)!
        self.wall2 = (self.childNode(withName: "wall2")as? SKSpriteNode)!
        self.wall3 = (self.childNode(withName: "wall3")as? SKSpriteNode)!
        self.wall4 = (self.childNode(withName: "wall4")as? SKSpriteNode)!
        self.wall5 = (self.childNode(withName: "wall5")as? SKSpriteNode)!
        self.wall6 = (self.childNode(withName: "wall6")as? SKSpriteNode)!
        self.wall7 = (self.childNode(withName: "wall7")as? SKSpriteNode)!
        self.wall8 = (self.childNode(withName: "wall8")as? SKSpriteNode)!
        self.wall9 = (self.childNode(withName: "wall9")as? SKSpriteNode)!
        self.wall10 = (self.childNode(withName: "wall10")as? SKSpriteNode)!
        self.wall11 = (self.childNode(withName: "wall11")as? SKSpriteNode)!
        self.wall12 = (self.childNode(withName: "wall12")as? SKSpriteNode)!
        self.wall13 = (self.childNode(withName: "wall13")as? SKSpriteNode)!
        self.wall14 = (self.childNode(withName: "wall14")as? SKSpriteNode)!
        self.wall15 = (self.childNode(withName: "wall15")as? SKSpriteNode)!
        self.wall16 = (self.childNode(withName: "wall16")as? SKSpriteNode)!
        self.wall17 = (self.childNode(withName: "wall17")as? SKSpriteNode)!
        self.wall18 = (self.childNode(withName: "wall18")as? SKSpriteNode)!
        self.wall19 = (self.childNode(withName: "wall19")as? SKSpriteNode)!
        self.wall20 = (self.childNode(withName: "wall20")as? SKSpriteNode)!
        self.wall21 = (self.childNode(withName: "wall21")as? SKSpriteNode)!
        self.wall22 = (self.childNode(withName: "wall22")as? SKSpriteNode)!
        self.wall23 = (self.childNode(withName: "wall23")as? SKSpriteNode)!
        self.wall24 = (self.childNode(withName: "wall24")as? SKSpriteNode)!
        self.wall25 = (self.childNode(withName: "wall25")as? SKSpriteNode)!
        self.wall26 = (self.childNode(withName: "wall26")as? SKSpriteNode)!
        self.wall27 = (self.childNode(withName: "wall27")as? SKSpriteNode)!
        self.wall28 = (self.childNode(withName: "wall28")as? SKSpriteNode)!
        self.wall29 = (self.childNode(withName: "wall29")as? SKSpriteNode)!
        self.wall30 = (self.childNode(withName: "wall30")as? SKSpriteNode)!
        self.wall31 = (self.childNode(withName: "wall31")as? SKSpriteNode)!
        self.wall32 = (self.childNode(withName: "wall32")as? SKSpriteNode)!
        self.wall33 = (self.childNode(withName: "wall33")as? SKSpriteNode)!
        self.wall34 = (self.childNode(withName: "wall34")as? SKSpriteNode)!
        self.wall35 = (self.childNode(withName: "wall35")as? SKSpriteNode)!
        
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
        
        walls = [wall1, wall2, wall3, wall4, wall5, wall6, wall7, wall8, wall9, wall10, wall11, wall12, wall13, wall14, wall15, wall16, wall17, wall18, wall19, wall20, wall21, wall22, wall23, wall24, wall25, wall26, wall27, wall28, wall29, wall30, wall31, wall32, wall33] as! [SKSpriteNode]
        
        centers = [centerOfSquare0, centerOfSquare1, centerOfSquare2, centerOfSquare3, centerOfSquare4, centerOfSquare5, centerOfSquare6, centerOfSquare7, centerOfSquare8, centerOfSquare9, centerOfSquare10, centerOfSquare11] as! [SKNode]
        
        for wall in walls{
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
        
        updateFeldemDirection(to: .standingStill)
        setupFeldem()
        animateFeldemStandingStill(state: .standingStill)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = (touch?.location(in: self))!
        let feldemDirection = calculateWalkingDirection(touchLocation: location)
        updateFeldemDirection(to: feldemDirection)
        moveFeldem(location: location)
    }
    
    func calculateWalkingDirection(touchLocation: CGPoint) -> WalkingDirection {
        let deltaX = (touchLocation.x - feldem.position.x)
        let deltaY = (touchLocation.y - feldem.position.y)
        let angle = atan2(deltaY, deltaX) < 0 ? atan2(deltaY, deltaX) + CGFloat.pi*2 : atan2(deltaY, deltaX)
        let angleDegrees = angle*180/CGFloat.pi
        
        switch angleDegrees {
        case 22,5...67,4:
            return .upperRight
        case 67,5...112,4:
            return .up
        case 112,5...157,4:
            return .upperLeft
        case 157,5...202,4:
            return .left
        case 202,5...247,4:
            return .downLeft
        case 247,5...292,4:
            return .down
        case 292,5...337,4:
            return .downRight
        case 337,5...360:
            return .right
        case 0...22,4:
            return .right
        default:
            print("ba fudeu gurizao")
            return .right
        }
    }
    
    // Character Functions
    func updateFeldemDirection(to direction: WalkingDirection) {
        let feldemAnimatedAtlas = SKTextureAtlas(named: direction.walkingDirectionName)
        var walkFrames: [SKTexture] = []
        
        let numImages = feldemAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let feldemTextureName = "feldem\(i)"
            walkFrames.append(feldemAnimatedAtlas.textureNamed(feldemTextureName))
        }
        feldemWalkingFrames = walkFrames
    }
    
    func setupFeldem() {
        let firstFrameTexture = feldemWalkingFrames[0]
        feldem = SKSpriteNode(texture: firstFrameTexture)
        feldem.position = centerOfSquare8!.position
        feldem.zPosition = 10
        feldem.name = "feldem"
        feldem.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width + 5, height: self.size.height))
        feldem.physicsBody?.affectedByGravity = false
        feldem.physicsBody?.allowsRotation = false
        feldem.physicsBody?.categoryBitMask = 1
        feldem.physicsBody?.collisionBitMask = 2
        feldem.physicsBody?.contactTestBitMask = 2
        addChild(feldem)
        feldem.setScale(0.05)
    }
    
    func animateFeldem() {
        feldem.run(SKAction.repeatForever(
            SKAction.animate(with: feldemWalkingFrames,
                             timePerFrame: 0.1,
                             resize: true,
                             restore: true)),
                   withKey: "walkingInPlaceFeldem")
    }
    
    func animateFeldemStandingStill(state: WalkingDirection) {
        updateFeldemDirection(to: state)
        feldem.run(SKAction.repeatForever(
            SKAction.animate(with: feldemWalkingFrames,
                             timePerFrame: 2,
                             resize: true,
                             restore: true)),
                   withKey: "standingStillFeldem")
    }
    
    func moveFeldem(location: CGPoint) {
        isMoving = true
        let feldemSpeed = frame.size.width / 5
        let moveDifference = CGPoint(x: location.x - feldem.position.x, y: location.y - feldem.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / feldemSpeed
        animateFeldem()

        let moveAction = SKAction.move(to: location, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in self?.feldemMoveEnded()})
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        feldem.run(moveActionWithDone, withKey: "feldemMoving")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if feldem.position.y >= (portalLight1!.position.y - portalLight1!.size.height/2){
            if feldem.position.x < (portalLight1!.position.x + portalLight1!.size.width/2) && feldem.position.x > (portalLight1!.position.x - portalLight1!.size.width/2){
                feldem.position = portalLight2!.position
                cameraTeste?.position = centerOfSquare6!.position
            }
        }
        
        for node in centers{
            if feldem.position.distance(point: node.position) < feldem.position.distance(point: cameraTeste!.position){
                cameraTeste?.run(SKAction.move(to: node.position, duration: 0.5))
            }
        }
        
        if !isMoving{
            timer += 1
            if timer == 390{
                updateFeldemDirection(to: .layingDown)
                animateFeldemStandingStill(state: .layingDown)
            }
            if timer == 800{
                updateFeldemDirection(to: .sleeping)
                animateFeldemStandingStill(state: .sleeping)
            }
        }
    }
    
    func feldemMoveEnded(){
        feldem.removeAllActions()
        timer = 0
        isMoving = false
        animateFeldemStandingStill(state: .standingStill)
    }
    
    func stopMoving(player: SKSpriteNode) {
        player.removeAction(forKey: "feldemMoving")
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "feldem" && contact.bodyB.node?.name == "wall"{
            feldemMoveEnded()
            if feldem.position.y < (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
            
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "wall"{
            feldemMoveEnded()
            if feldem.position.y < (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "gate"{
            feldemMoveEnded()
            if feldem.position.y < (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyA.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyA.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
        
        if contact.bodyA.node?.name == "feldem" && contact.bodyB.node?.name == "gate"{
            feldemMoveEnded()
            if feldem.position.y < (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
            if feldem.position.y > (contact.bodyB.node?.position.y)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x > (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y + 5, duration: 0.1))
            }
            if feldem.position.x < (contact.bodyB.node?.position.x)!{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
    }
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}

