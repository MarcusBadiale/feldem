//
//  WalkingDirection.swift
//  Feldem
//
//  Created by Gustavo Travassos on 07/08/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//

import SpriteKit

enum State {
    case feldemUp, feldemDown, feldemLeft, feldemRight, feldemUpperRight, feldemUpperLeft, feldemDownLeft, feldemDownRight, feldemStandingStill, feldemLayingDown, feldemSleeping, firstGhost, secondGhost, thirdGhost, smokeGhost, demon
    
    var walkingDirectionName: String {
        switch self {
        case .feldemLeft:
            return "walkingLeft"
        case .feldemRight:
            return "walkingRight"
        case .feldemUp:
            return "walkingUp"
        case .feldemDown:
            return "walkingDown"
        case .feldemDownLeft:
            return "walkingDownLeft"
        case .feldemDownRight:
            return "walkingDownRight"
        case .feldemUpperLeft:
            return "walkingUpperLeft"
        case .feldemUpperRight:
            return "walkingUpperRight"
        case .feldemStandingStill:
            return "standingStill"
        case .feldemLayingDown:
            return "layingDown"
        case .feldemSleeping:
            return "sleeping"
        case .firstGhost:
            return "ghost"
        case .secondGhost:
            return "ghost2"
        case .thirdGhost:
            return "ghost3"
        case .smokeGhost:
            return "smokeGhost"
        case .demon:
            return "demon"
        }
    }
}
