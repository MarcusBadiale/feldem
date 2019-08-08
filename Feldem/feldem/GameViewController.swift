//
//  GameViewController.swift
//  temporary Game
//
//  Created by Marcus Vinicius Vieira Badiale on 24/07/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: GameScene?
    var lightWorld = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                self.scene = scene
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWorld()
        
        for gate in scene!.gates{
            print(gate)
        }
    }
    
    fileprivate func updateWorld() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            
            scene?.background?.texture = SKTexture(imageNamed: "backgroundDark")
            scene?.tree?.texture = SKTexture(imageNamed: "tree_dark")
            
            for wall in scene!.darkwalls + scene!.walls{
                wall.removeFromParent()
            }
            //
            for wall in scene!.darkwalls{
                scene!.addChild(wall)
            }
            
            for gate in scene!.gates{
                gate.alpha = 0
                //                gate.physicsBody = .none
            }
            
        default:
            
            scene?.background?.texture = SKTexture(imageNamed: "background")
            scene?.tree?.texture = SKTexture(imageNamed: "tree")
            
            for wall in scene!.darkwalls + scene!.walls{
                wall.removeFromParent()
            }
            //
            for wall in scene!.walls{
                scene!.addChild(wall)
            }
            
            for gate in scene!.gates{
                gate.alpha = 1
//                gate.physicsBody = SKPhysicsBody(rectangleOf: gate.size)
            }

        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            lightWorld = true
            switchSongs(mode: lightWorld)
        case .landscapeLeft, .landscapeRight:
            lightWorld = false
            switchSongs(mode: lightWorld)
        default: print("?????")
        }
        updateWorld()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
