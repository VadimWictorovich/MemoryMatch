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
    var actionHandler: (Actions) -> Void = { _ in }
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "background")
        let sprite = SKSpriteNode(texture: texture)
        return sprite
    }()

    private lazy var startGameButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.actionHandler(.startGame)
        }
        return view
    }()
    
    private lazy var privacyPolicyButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.actionHandler(.privacyPolicy)
        }
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
        setupButtons()
    }
    
    // MARK: METHODS
    private func setupButtons() {
        addItems()
        addItems()
        
        self.actionHandler = { [weak self] action in
            switch action {
            case .startGame:
                self?.viewModel.startGame()
            case .privacyPolicy:
                self?.viewModel.openPrivacyPolicy()
            }
        }
    }
    
    private func addItems() {
        addChild(background)
        addChild(startGameButton)
        addChild(privacyPolicyButton)
    }
}
