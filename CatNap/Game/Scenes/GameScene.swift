//
//  GameScene.swift
//  CatNap
//
//  Created by Alexey Sobolevsky on 04/10/2019.
//  Copyright © 2019 Alexey Sobolevsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var playableRect: CGRect = .zero
    private var playable = true


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
        physicsBody?.categoryBitMask = PhysicsCategory.edge.rawValue
        physicsWorld.contactDelegate = self

        // /name - search in the root
        // //name - search starting at the root and moving recursively down the hierarchy
        // * - any node name
        enumerateChildNodes(withName: "//*") { (node, _) in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        }

        setupNodes()
        SKTAudio.shared.playBackgroundMusic(Resources.Audio.backgroundMusic)
    }

    override func update(_ currentTime: TimeInterval) {
    }


    // MARK: - Setup

    private func setupNodes() {
        bedNode = childNode(withName: .bedNodeName) as? BedNode
        catNode = childNode(withName: "//\(String.catNodeName)") as? CatNode
    }

    @objc private func newGame() {
        let scene = GameScene(fileNamed: "GameScene")
        scene?.scaleMode = scaleMode
        view?.presentScene(scene)
    }

    private func lose() {
        playable = false

        SKTAudio.shared.pauseBackgroundMusic()
        SKTAudio.shared.playSoundEffect(Resources.Audio.lose)

        inGameMessage(text: "Try again...")

        perform(#selector(newGame), with: nil, afterDelay: 5)

        catNode.wakeUp()
    }

    private func win() {
        playable = false

        SKTAudio.shared.pauseBackgroundMusic()
        SKTAudio.shared.playSoundEffect(Resources.Audio.win)

        inGameMessage(text: "Nice job!")

        perform(#selector(newGame), with: nil, afterDelay: 3)

        catNode.curlAt(scenePoint: bedNode.position)
    }

    // MARK: - Helpers

    private func inGameMessage(text: String) {
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
    }

}


// MARK: - SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        guard playable else { return }

        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch collision {
        case PhysicsCategory.cat.rawValue | PhysicsCategory.bed.rawValue:
            print("Success")
            win()

        case PhysicsCategory.cat.rawValue | PhysicsCategory.edge.rawValue:
            print("Fail")
            lose()

        default: break
        }
    }


}

private extension String {
    static let bedNodeName = "bed"
    static let catNodeName = "cat_body"
    static let blockNodeName = "block"
}
