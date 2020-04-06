//
//  MessageNode
//  CatNap
//
//  Created by Alexey Sobolevsky on 09/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit

final class MessageNode: SKLabelNode {

    private var bounceCount = 0

    convenience init(message: String) {
        self.init(fontNamed: Resources.Fonts.message)

        text = message
        name = "message"
        fontSize = 256
        fontColor = SKColor.gray
        zPosition = 100

        let front = SKLabelNode(fontNamed: Resources.Fonts.message)
        front.text = message
        front.fontSize = 256
        front.fontColor = SKColor.white
        front.position = CGPoint(x: -2, y: -2)
        addChild(front)

        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody?.categoryBitMask = PhysicsCategory.label.rawValue
        physicsBody?.collisionBitMask = PhysicsCategory.edge.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategory.edge.rawValue
        physicsBody?.restitution = 0.7
    }

    func didBounce() {
        bounceCount += 1

        if bounceCount >= 4 {
            bounceCount = 0
            removeFromParent()
        }
    }

}

