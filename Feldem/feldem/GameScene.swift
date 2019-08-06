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
    
    enum WalkingDirection {
        case up, down, left, right, upperRight, upperLeft, downLeft, downRight, standingStill, layingDown
        
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
            }
        }
    }
    
    var background: SKSpriteNode?
    var cameraTeste: SKCameraNode?
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
    
    private var feldem = SKSpriteNode()
    private var feldemWalkingFrames: [SKTexture] = []
    
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
        
        updateFeldemDirection(to: .standingStill)
        setupFeldem()
        animateFeldemStandingStill()
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
        feldem.position = cameraTeste!.position
        feldem.zPosition = 10
        feldem.name = "feldem"
        feldem.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        feldem.physicsBody?.affectedByGravity = false
        feldem.physicsBody?.allowsRotation = false
        feldem.physicsBody?.categoryBitMask = 1
        feldem.physicsBody?.collisionBitMask = 2
        feldem.physicsBody?.contactTestBitMask = 2
        addChild(feldem)
        feldem.setScale(0.07)
    }
    
    func animateFeldem() {
        feldem.run(SKAction.repeatForever(
            SKAction.animate(with: feldemWalkingFrames,
                             timePerFrame: 0.1,
                             resize: true,
                             restore: true)),
                   withKey: "walkingInPlaceFeldem")
    }
    
    func animateFeldemStandingStill() {
        updateFeldemDirection(to: .standingStill)
        feldem.run(SKAction.repeatForever(
            SKAction.animate(with: feldemWalkingFrames,
                             timePerFrame: 2,
                             resize: true,
                             restore: true)),
                   withKey: "standingStillFeldem")
    }
    
    func moveFeldem(location: CGPoint) {
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
        // Called before each frame is rendered
        
        for node in centers{
            if feldem.position.distance(point: node.position) < feldem.position.distance(point: cameraTeste!.position){
                cameraTeste?.run(SKAction.move(to: node.position, duration: 0.5))
            }
        }
    }
    
    func feldemMoveEnded(){
        feldem.removeAllActions()
        animateFeldemStandingStill()
    }
    
    func stopMoving(player: SKSpriteNode) {
        player.removeAction(forKey: "feldemMoving")
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "feldem" && contact.bodyB.node?.name == "wall"{
            feldemMoveEnded()
            if feldem.position.y < wall!.position.y{
                feldem.run(SKAction.moveTo(y: feldem.position.y - 5, duration: 0.1))
            }
        }
        
        if contact.bodyB.node?.name == "feldem" && contact.bodyA.node?.name == "wall"{
            feldemMoveEnded()
            if feldem.position.y < wall!.position.y{
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

