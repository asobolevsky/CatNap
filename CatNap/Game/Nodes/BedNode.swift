//
//  BedNode.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 05/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit

final class BedNode: SKSpriteNode, EventListenerNode {

    // MARK: - EventListenerNode

    func didMoveToScene() {
        let bedBodySize = CGSize(width: 400, height: 30)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicsCategory.bed.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.none.rawValue
    }

}
