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
    
    private var feldem = SKSpriteNode()
    private var feldemWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        camera = cameraTeste
        
        if let background = self.background{
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        
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
        
        let positionInScene = touch?.location(in: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
        feldem.position = CGPoint(x: frame.midX, y: frame.midY)
        feldem.zPosition = 10
        addChild(feldem)
        feldem.setScale(0.1)
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
    
    func feldemMoveEnded() {
        feldem.removeAllActions()
        animateFeldemStandingStill()
    }
    
    
}
