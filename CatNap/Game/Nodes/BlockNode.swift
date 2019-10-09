//
//  BlockNode.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 09/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit

final class BlockNode: SKSpriteNode, EventListenerNode, InterectiveNode {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("destroy block")
        interact()
    }


    // MARK: - EventListenerNode

    func didMoveToScene() {
        isUserInteractionEnabled = true
        physicsBody?.categoryBitMask = PhysicsCategory.block.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.block.rawValue |
                                        PhysicsCategory.cat.rawValue |
                                        PhysicsCategory.edge.rawValue
    }


    // MARK: - InterectiveNode

    func interact() {
        isUserInteractionEnabled = false

        run(SKAction.sequence([
            SKAction.playSoundFileNamed(Resources.Audio.pop, waitForCompletion: false),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.removeFromParent()
        ]))
    }

}
