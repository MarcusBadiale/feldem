//
//  Lever.swift
//  Feldem
//
//  Created by Gustavo Travassos on 13/08/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//

import SpriteKit

class Lever: SKNode {
    enum LeverType {
        case light, dark, portal
        
        var leverFolderName: String {
            switch self {
            case .dark: return "leverDark"
            case .light: return "leverLight"
            case .portal: return "leverPortal"
            }
        }
    }
    
    var leverType: LeverType?
    var leverState: Bool = false
    var leverFrames: [SKTexture] = []
    var lever = SKSpriteNode()
    var leverFileName = ""
    
    override init(){
        super.init()
    }
    
    convenience init(type: LeverType, state: Bool){
        self.init()
        self.leverType = type
        self.leverState = state
        self.leverFileName = leverType!.leverFolderName
        setupLever()
        updateState(to: false, type: leverType ?? .portal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState(to state: Bool, type: LeverType) {
        let leverAnimatedAtlas = SKTextureAtlas(named: type.leverFolderName)
        var frames: [SKTexture] = []
        let numImages = leverAnimatedAtlas.textureNames.count
        
        switch state {
        case true:
            for i in numImages...1{
                let leverTextureName = "\(leverFileName)\(i)"
                frames.append(leverAnimatedAtlas.textureNamed(leverTextureName))
            }
        case false:
            for i in 1...numImages{
                let leverTextureName = "\(leverFileName)\(i)"
                frames.append(leverAnimatedAtlas.textureNamed(leverTextureName))
            }
        }
        leverFrames = frames
    }
    
    func setupLever() {
        let firstFrameTexture = leverFrames[0]
        lever = SKSpriteNode(texture: firstFrameTexture)
        zPosition = 8
    }
    
    func animateLever(){
        lever.run(SKAction.animate(with: leverFrames, timePerFrame: 0.33))
        switch leverState{
        case true: leverState = false
        case false: leverState = true
        }
    }
}
