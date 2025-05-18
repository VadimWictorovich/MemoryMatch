//
//  WinScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

class WinScene: SKScene {
    
    private enum Actions {
        case restart
        case menu
    }
    
    private var actionHandler: (Actions) -> Void = { _ in }
    
    private lazy var fire: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "fire")
        let sprite = SKSpriteNode(texture: texture)
        return sprite
    }()
    
    private lazy var youWinLabel: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "youWin")
        let sprite = SKSpriteNode(texture: texture)
        return sprite
    }()
    
    private lazy var board: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "board")
        let sprite = SKSpriteNode(texture: texture)
        let moviesLabel = SKLabelNode(text: "MOVIES: 12")
        let timeLabel = SKLabelNode(text: "00:12")
        sprite.addChild(moviesLabel)
        sprite.addChild(timeLabel)
        return sprite
    }()
    
    private lazy var restartButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.actionHandler(.restart)
        }
        return view
    }()
    
    private lazy var menuButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.actionHandler(.menu)
        }
        return view
    }()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
          
          // Делаем фон прозрачным
//          self.backgroundColor = .clear
          // или
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        
        addItems()
        setupUI()
      }
    
    private func addItems() {
        addChild(fire)
        addChild(board)
        board.addChild(youWinLabel)
        addChild(restartButton)
        addChild(menuButton)
    }
    
    private func setupUI() {
        
    }
}
