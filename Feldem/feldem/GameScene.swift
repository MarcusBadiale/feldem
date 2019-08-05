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
    
    private var feldem = SKSpriteNode()
    private var feldemWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        
        self.background = (self.childNode(withName: "background") as? SKSpriteNode)!
        self.cameraTeste = (self.childNode(withName: "cameraTeste") as? SKCameraNode)!
        camera = cameraTeste
        
        if let background = self.background{
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        
        buildFeldem(AssetFolder: "...")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        
        cameraTeste?.position.x += 10
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Move Feldem
        let touch = touches.first!
        let location = touch.location(in: self)
        movePanda(location: location)
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // Character Functions
    func buildFeldem(AssetFolder: String) {
        let feldemAnimatedAtlas = SKTextureAtlas(named: AssetFolder)
        var walkFrames: [SKTexture] = []
        
        let numImages = feldemAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let feldemTextureName = "feldem\(i)"
            walkFrames.append(feldemAnimatedAtlas.textureNamed(feldemTextureName))
        }
        feldemWalkingFrames = walkFrames
        let firstFrameTexture = feldemWalkingFrames[0]
        feldem = SKSpriteNode(texture: firstFrameTexture)
        feldem.position = CGPoint(x: frame.midX, y: frame.midY)
        feldem.zPosition = 10
        addChild(feldem)
    }
    
    func animateFeldem() {
        feldem.run(SKAction.repeatForever(
            SKAction.animate(with: feldemWalkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                   withKey: "walkingInPlaceFeldem")
    }
    
    func moveFeldem(location: CGPoint) {
        var multiplierForDirection: CGFloat
        let feldemSpeed = frame.size.width / 5
        let moveDifference = CGPoint(x: location.x - feldem.position.x, y: location.y - feldem.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / feldemSpeed
        if moveDifference.x < 0 {
            multiplierForDirection = -1
        } else {
            multiplierForDirection = 1
        }
        feldem.xScale = abs(feldem.xScale) * multiplierForDirection
        if feldem.action(forKey: "walkingInPlaceFeldem") == nil {
            animateFeldem()
        }
        let moveAction = SKAction.move(to: location, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in self?.feldemMoveEnded})
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        panda.run(moveActionWithDone, withKey: "feldemMoving")
    }
    
    func feldemMoveEnded() {
        feldem.removeAllActions()
    }
    
    
}
