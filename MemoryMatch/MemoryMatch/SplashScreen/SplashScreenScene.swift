//
//  SplashScreenScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 23.05.25.
//

import SpriteKit

class SplashScreenScene: SKScene {
    
    private var logoNode: SKSpriteNode?
        
    override func didMove(to view: SKView) {
        setupBackground()
        setupLogo()
        setupLabel()
        startFlameAnimation()
    }
        
    private func setupBackground() {
        let background = SKSpriteNode(imageNamed: "bg_1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        background.scaleToFitScreen(scene: self)
        addChild(background)
    }
        
    private func setupLogo() {
        let logo = SKSpriteNode(imageNamed: "Огонь124")
        logo.setScale(0.3)
        logo.position = CGPoint(x: size.width / 2, y: size.height / 2 + 200)
        addChild(logo)
        self.logoNode = logo
    }
        
    private func setupLabel() {
        let label = SKLabelNode(text: "Loading...")
        label.fontName = "Helvetica-Bold"
        label.fontSize = 24
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }
        
    private func startFlameAnimation() {
        guard let logo = logoNode else { return }
            
        let moveUp = SKAction.moveBy(x: 0, y: -50, duration: 1.0)
        let moveDown = moveUp.reversed()
        let sequence = SKAction.sequence([moveUp, moveDown])
        let loop = SKAction.repeatForever(sequence)
            
        logo.run(loop)
    }
        
    func simulateLoading(completion: @escaping () -> Void) {
        run(SKAction.wait(forDuration: 3.0)) {
            completion()
        }
    }
}
