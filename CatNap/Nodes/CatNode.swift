//
//  CatNode.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 05/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit

final class CatNode: SKSpriteNode, EventListenerNode {

    // MARK: - EventListenerNode

    func didMoveToScene() {
        isPaused = false

        let texture = SKTexture(imageNamed: "cat_body_outline")
        parent?.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
    }

}
