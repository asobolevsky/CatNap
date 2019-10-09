//
//  CatNode.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 05/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit

final class CatNode: SKSpriteNode, EventListenerNode {

    func wakeUp() {
        children.forEach { $0.removeFromParent() }
        texture = nil
        color = SKColor.clear // Resets to an empty node

        guard let catAwakeScene = SKSpriteNode(fileNamed: "CatWakeUp"),
            let catAwake = catAwakeScene.childNode(withName: "cat_awake") else {
                return
        }

        catAwake.move(toParent: self) // Removes node from currect hierarchy and moves to the given one
        catAwake.position = CGPoint(x: -30, y: 100)
    }

    func curlAt(scenePoint: CGPoint) {
        parent?.physicsBody = nil

        children.forEach { $0.removeFromParent() }
        texture = nil
        color = SKColor.clear

        guard let catCurlScene = SKSpriteNode(fileNamed: "CatCurl"),
            let catCurl = catCurlScene.childNode(withName: "cat_curl") else {
                return
        }

        catCurl.move(toParent: self)
        catCurl.position = CGPoint(x: -10, y: 50)

        guard let scene = scene, let parent = parent else { return }

        var localPoint = parent.convert(scenePoint, to: scene)
        localPoint.y = -frame.height / 3

        run(SKAction.sequence([
            SKAction.move(to: localPoint, duration: 0.66),
            SKAction.rotate(toAngle: -parent.zRotation, duration: 0.5)
        ]))
    }

    // MARK: - EventListenerNode

    func didMoveToScene() {
        isPaused = false

        let texture = SKTexture(imageNamed: "cat_body_outline")
        parent?.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        parent?.physicsBody?.categoryBitMask = PhysicsCategory.cat.rawValue
        parent?.physicsBody?.collisionBitMask = PhysicsCategory.block.rawValue |
            PhysicsCategory.edge.rawValue
        parent?.physicsBody?.contactTestBitMask = PhysicsCategory.bed.rawValue |
            PhysicsCategory.edge.rawValue
    }

}
