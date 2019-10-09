//
//  PhysicsCategory.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 09/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import Foundation

struct PhysicsCategory: OptionSet {

    let rawValue: UInt32

    static let none     = PhysicsCategory(rawValue: 0)
    static let cat      = PhysicsCategory(rawValue: 1 << 0)
    static let block    = PhysicsCategory(rawValue: 1 << 1)
    static let bed      = PhysicsCategory(rawValue: 1 << 2)
    static let edge     = PhysicsCategory(rawValue: 1 << 3)
    static let label    = PhysicsCategory(rawValue: 1 << 4)
}
