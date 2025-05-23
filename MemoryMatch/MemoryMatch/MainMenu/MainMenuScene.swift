//
//  MainMenuScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

final class MainMenuScene: SKScene {
    
    // MARK: PROPERTIES
    var viewModel: MainMenuViewModelProtocol
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_1")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        sprite.scaleToFitScreen(scene: self)
        sprite.zPosition = -2
        sprite.isUserInteractionEnabled = false
        return sprite
    }()
    
    private lazy var secondBackground: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_1_1")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        sprite.scaleToFitScreen(scene: self)
        sprite.zPosition = -1
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

    private lazy var startGameButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 628, height: 154, screenSize: self.size)
        let view = DefaultButton(nameImage: "Play_button", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.viewModel.actionHandler(.startGame)
        }
        view.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        view.zPosition = 2
        return view
    }()
    
    private lazy var privacyPolicyButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 456, height: 88, screenSize: self.size)
        let view = DefaultButton(nameImage: "privacy_button", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.viewModel.actionHandler(.privacyPolicy)
        }
        view.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        view.zPosition = 2
        return view
    }()
    
    // MARK: LIFECIRCLE
    init(size: CGSize, viewModel: MainMenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(size: size)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addItems()
        setupActions()
    }
    
    // MARK: METHODS
    private func addItems() {
        addChild(background)
        addChild(secondBackground)
        addChild(hatNode)
        addChild(startGameButton)
        addChild(privacyPolicyButton)
    }
    
    private func setupActions() {
        viewModel.actionHandler = { [weak self] action in
            switch action {
            case .startGame:
                self?.viewModel.startGame()
            case .privacyPolicy:
                self?.viewModel.openPrivacyPolicy()
            }
        }
    }
}

