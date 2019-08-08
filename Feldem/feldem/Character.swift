//
//  Character.swift
//  Feldem
//
//  Created by Gustavo Travassos on 07/08/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//

import SpriteKit

class Character: SKNode {
    
    var characterName: String = ""
    var characterSpeed: Int = 0
    
    var character = SKSpriteNode()
    var characterWalkingFrames: [SKTexture] = []
    var isMoving = false

    override init() {
        super.init()
    }

    convenience init(name: String, speed: Int, size: CGSize, characterPosition: CGPoint) {
        self.init()
        self.characterName = name
        self.characterSpeed = speed
        super.position = characterPosition
        
        checkAndSetup(name: name, size: size, speed: speed)
        addChild(character)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkAndSetup (name: String, size: CGSize, speed: Int) {
        switch name {
        case "feldem":
            updateCharacterState(to: .feldemDown)
            setupCharacter(size: size)
            animateCharacter(state: .feldemStandingStill, timePerFrame: 1.5)
        case "ghost", "smokeGhost":
            switch speed{
            case 200:
                updateCharacterState(to: .firstGhost)
                setupCharacter(size: size)
                animateCharacter(state: .firstGhost, timePerFrame: 0.5)
            case 225:
                updateCharacterState(to: .secondGhost)
                setupCharacter(size: size)
                animateCharacter(state: .secondGhost, timePerFrame: 0.4)
            case 250:
                updateCharacterState(to: .thirdGhost)
                setupCharacter(size: size)
                animateCharacter(state: .thirdGhost, timePerFrame: 0.3)
            case 275:
                updateCharacterState(to: .smokeGhost)
                setupCharacter(size: size)
                animateCharacter(state: .smokeGhost, timePerFrame: 0.2)
            default: print("incorrect speed")
            }
        default:
            print("incorrect name")
        }
        
    }
    
    func setupCharacter(size: CGSize) {
        let firstFrameTexture = characterWalkingFrames[0]
        character = SKSpriteNode(texture: firstFrameTexture, size: size)
        zPosition = 10
        character.name = name
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = 1
        physicsBody?.collisionBitMask = 2
        physicsBody?.contactTestBitMask = 2
        
        switch characterName {
        case "feldem":
            setScale(0.07)
            name = "feldem"
            character.name = "feldem"
        default:
            setScale(0.1)
        }
    }

    func animateCharacter(state: State, timePerFrame: TimeInterval) {
        updateCharacterState(to: state)
        character.run(SKAction.repeatForever(
            SKAction.animate(with: characterWalkingFrames,
                             timePerFrame: timePerFrame,
                             resize: true,
                             restore: true)),
                   withKey: "walkingInPlaceCharacter")
    }

    func updateCharacterState(to direction: State) {
        let characterAnimatedAtlas = SKTextureAtlas(named: direction.walkingDirectionName)
        var walkFrames: [SKTexture] = []
        let numImages = characterAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let characterTextureName = "\(characterName)\(i)"
            walkFrames.append(characterAnimatedAtlas.textureNamed(characterTextureName))
        }
        characterWalkingFrames = walkFrames
    }

    func moveCharacter(to location: CGPoint) {
        isMoving = true
        let moveDifference = CGPoint(x: location.x - position.x, y: location.y - position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / CGFloat(characterSpeed)
        let walkingDirection = calculateWalkingDirection(touchLocation: location)
        animateCharacter(state: walkingDirection, timePerFrame: 0.1)

        let moveAction = SKAction.move(to: location, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in self?.characterMoveEnded()})
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        run(moveActionWithDone, withKey: "characterMoving")
    }

    func characterMoveEnded(){
        removeAllActions()
        isMoving = false
        animateCharacter(state: .feldemStandingStill, timePerFrame: 1.5)
    }
    
    func calculateWalkingDirection(touchLocation: CGPoint) -> State {
        let deltaX = (touchLocation.x - position.x)
        let deltaY = (touchLocation.y - position.y)
        let angle = atan2(deltaY, deltaX) < 0 ? atan2(deltaY, deltaX) + CGFloat.pi*2 : atan2(deltaY, deltaX)
        let angleDegrees = angle*180/CGFloat.pi
        
        switch angleDegrees {
        case 22.5...67.4: return .feldemUpperRight
        case 67.5...112.5: return .feldemUp
        case 112.5...157.5: return .feldemUpperLeft
        case 157.5...202.5: return .feldemLeft
        case 202.5...247.5: return .feldemDownLeft
        case 247.5...292.5: return .feldemDown
        case 292.5...337.5: return .feldemDownRight
        case 337.5...360: return .feldemRight
        case 0...22.5: return .feldemRight
        default:
            print("ba fudeu gurizao")
            return .feldemRight
        }
    }
}
