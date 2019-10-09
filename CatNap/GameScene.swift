//
//  GameScene.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 04/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol EventListenerNode {
    func didMoveToScene()
}

class GameScene: SKScene {

    private var playableRect: CGRect = .zero

    // MARK: - Nodes

    private var bedNode: BedNode!
    private var catNode: CatNode!


    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        let scale = UIScreen.main.nativeScale
        let playableHeight = view.frame.size.height * scale
        let playableMargin = (size.height - playableHeight) / (scale * 2)
        playableRect = CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2 + playableMargin),
                              size: CGSize(width: size.width, height: size.height - playableMargin * 2))
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)

        let circle = SKShapeNode(circleOfRadius: 40)
        circle.fillColor = SKColor.red
        circle.position = playableRect.origin
        addChild(circle)

        // /name - search in the root
        // //name - search starting at the root and moving recursively down the hierarchy
        // * - any node name
        enumerateChildNodes(withName: "//*") { (node, _) in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        }

        setupNodes()
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
    }

    override func update(_ currentTime: TimeInterval) {
    }


    // MARK: - Setup

    private func setupNodes() {
        bedNode = childNode(withName: .bedNodeName) as? BedNode
        catNode = childNode(withName: "//\(String.catNodeName)") as? CatNode
    }

}


private extension String {
    static let bedNodeName = "bed"
    static let catNodeName = "cat_body"
    static let blockNodeName = "block"
}
