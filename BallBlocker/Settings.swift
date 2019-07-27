//
//  Settings.swift
//  Tanks
//
//  Created by Westin Vu on 7/10/19.
//  Copyright © 2019 LearnAppMaking. All rights reserved.
//

import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0 //physics categories in spritekit are always UInt32
    static let bulletCategory: UInt32 = 0x1 //1
    static let redBallCategory: UInt32 = 0x1 << 1 //10
    static let blueBallCategory: UInt32 = 0x1 << 2
    static let borderCategory: UInt32 = 0x1 << 3
}

enum ZPositions{
    static let scoreLabel: CGFloat = 0
    static let balls: CGFloat = 1
    static let bullet: CGFloat = 2
    
}
