//
//  GameplayScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

class GameplayScene: SKScene {

    var viewModel: GameplayViewModelProtocol
    var acttionHandler: (GameplayActions) -> Void = { _ in }
    
    private lazy var displayBoard: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "board")
        let view = SKSpriteNode(texture: texture)
        let label = SKLabelNode(text: "123")
        view.addChild(label)
        return view
    }()
    
    private lazy var settingsButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.acttionHandler(.settings)
        }
        return view
    }()
    
    private lazy var pauseButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.acttionHandler(.pause)
        }
        return view
    }()
    
    private lazy var cancelMoveButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.acttionHandler(.cancelMove)
        }
        return view
    }()
    
    private lazy var restartButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.acttionHandler(.restart)
        }
        return view
    }()
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "background")
        let sprite = SKSpriteNode(texture: texture)
        return sprite
    }()
    
    init(size: CGSize, viewModel: GameplayViewModelProtocol) {
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
    
    private func setupButtons() {
        acttionHandler = { [weak self] action in
            
            switch action {
            case .flip:
                self?.viewModel.flipCard()
            case .settings:
                self?.viewModel.openSettings()
            case .pause:
                self?.viewModel.pauseGame()
            case .cancelMove:
                self?.viewModel.cancelMove()
            case .restart:
                self?.viewModel.restartGame()
            }
        }
    }
    
    private func addItems() {
        addChild(background)
        background.addChild(settingsButton)
        background.addChild(displayBoard)
        background.addChild(pauseButton)
        background.addChild(cancelMoveButton)
        background.addChild(restartButton)
    }
}


final class CardTable: SKNode {
    
    private lazy var cards: [Card] = []
    
    private func setupCards() {
//        addChild(cards)
    }
}






