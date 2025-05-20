//
//  NotoficationsScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 20.05.25.
//

import SpriteKit

class NotoficationsScene: SKScene {
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_1")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let aspectRatio = texture.size().width / texture.size().height
        let screenAspectRatio = self.size.width / self.size.height
        
        if screenAspectRatio > aspectRatio {
            sprite.size.width = self.size.width
            sprite.size.height = self.size.width / aspectRatio
        } else {
            sprite.size.height = self.size.height
            sprite.size.width = self.size.height * aspectRatio
        }
        
        sprite.zPosition = -2
        sprite.isUserInteractionEnabled = false
        return sprite
    }()
    
    private lazy var hatNode: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "hat")
        let sprite = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 949, height: 949, screenSize: self.size)
        sprite.size = scaledSize
        sprite.zPosition = 1
        sprite.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        return sprite
    }()
    
    private lazy var firstLabel: SKLabelNode = {
        let view = SKLabelNode(fontNamed: "Arial")
        view.fontName = UIFont.boldSystemFont(ofSize: 20).fontName
        view.fontSize = 20
        view.fontColor = .white
        view.text = "Allow notifications about \n bonuses and promos"
        view.position = CGPoint(x: frame.midX, y: frame.midY - 160)
        view.zPosition = 1
        return view
    }()
    
    private lazy var secondLabel: SKLabelNode = {
        let view = SKLabelNode(fontNamed: "Arial")
        view.fontSize = 15
        view.fontColor = .gray
        view.text = "Stay tuned with best offers from \n our casino"
        view.position = CGPoint(x: frame.midX, y: frame.midY - 260)
        view.zPosition = 1
        return view
    }()
    
    private lazy var yesButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 628, height: 154, screenSize: self.size)
        let view = DefaultButton(nameImage: "yellowButton", width: scaledSize.width, height: scaledSize.height)
        view.position = CGPoint(x: frame.midX, y: frame.midY - 350)
        view.zPosition = 2
        return view
    }()
    
    private lazy var skipButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 456, height: 88, screenSize: self.size)
        let view = DefaultButton(nameImage: "privacy_button", width: scaledSize.width, height: scaledSize.height)
        view.position = CGPoint(x: frame.midX, y: frame.midY - 380)
        view.zPosition = 2
        return view
    }()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addItems()
    }
    
    private func addItems() {
        addChild(background)
        addChild(hatNode)
        addChild(firstLabel)
        addChild(secondLabel)
        addChild(yesButton)
        addChild(skipButton)
    }
}
