//
//  ContentView.swift
//  embarnes-hello-world
//
//  Created by Edward Barnes on 30/11/2025.
//

import SpriteKit
import SwiftUI

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = .zero
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Limit to 6 circles
        let circles = children.compactMap { $0 as? SKShapeNode }
        if circles.count >= 10 { return }
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        print("Touch at x=\(location.x), y=\(location.y)")
        
        // 1. Random radius and appearance
        let radius = CGFloat.random(in: 20...50)
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.fillColor = SKColor.blue
        circle.position = location
        
        // 2. Add Physics Body
        circle.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        // 3. Sensible Physics Settings
        circle.physicsBody?.restitution = 1.0    // Full bounciness (no energy loss)
        circle.physicsBody?.friction = 0.0       // No slowing down on walls
        circle.physicsBody?.linearDamping = 0.0  // No air resistance
        circle.physicsBody?.allowsRotation = false
        
        // 4. Random Velocity (dx/dy)
        let randomX = CGFloat.random(in: -300...300)
        let randomY = CGFloat.random(in: -300...300)
        circle.physicsBody?.velocity = CGVector(dx: randomX, dy: randomY)
        
        addChild(circle)
    }
}


struct ContentView: View {
    let scene: SKScene = {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 800)
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

