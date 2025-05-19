//
//  GameplayScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit
import AudioToolbox
import UIKit

class GameplayScene: SKScene {

    var viewModel: GameplayViewModelProtocol
    var acttionHandler: (GameplayActions) -> Void = { _ in }
    
    private var moviesValue = 0 {
        didSet {
            moviesLabelValue = "MOVIES: \(moviesValue)"
        }
    }
    private var moviesLabelValue = "MOVIES: 0"
    private var timer: Timer?
    
    
    private lazy var displayBoard: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "board")
        let view = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 973, height: 120, screenSize: self.size)
        view.size = scaledSize
//        let label = SKLabelNode(text: "123")
//        view.addChild(label)
        view.position = CGPoint(x: frame.midX, y: frame.midY + 284)
        view.zPosition = 1
        return view
    }()
    
    private lazy var settingsButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Settings", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.acttionHandler(.settings)
        }
        view.position = CGPoint(x: frame.midX - 150, y: frame.midY + 336)
        view.zPosition = 1
        return view
    }()
    
    private lazy var cardTable: CardTable = {
        let cardSize = CGSize.scaled(width: 220, height: 220, screenSize: self.size)
        let table = CardTable(scaledSize: cardSize)
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        return table
    }()
    
    private lazy var pauseButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Pause", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.acttionHandler(.pause)
        }
        view.position = CGPoint(x: frame.midX - 160, y: frame.midY - 320)
        view.zPosition = 1
        return view
    }()
    
    private lazy var cancelMoveButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Left", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.acttionHandler(.cancelMove)
        }
        view.position = CGPoint(x: frame.midX, y: frame.midY - 320)
        view.zPosition = 1
        return view
    }()
    
    private lazy var restartButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Undo", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.acttionHandler(.restart)
        }
        view.position = CGPoint(x: frame.midX + 160, y: frame.midY - 320)
        view.zPosition = 1
        return view
    }()
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_2")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let aspectRatio = texture.size().width / texture.size().height
        let screenAspectRatio = self.size.width / self.size.height
        
        if screenAspectRatio > aspectRatio {
            // Экран шире чем изображение
            sprite.size.width = self.size.width
            sprite.size.height = self.size.width / aspectRatio
        } else {
            // Экран уже чем изображение
            sprite.size.height = self.size.height
            sprite.size.width = self.size.height * aspectRatio
        }
        sprite.zPosition = -1
        sprite.isUserInteractionEnabled = false
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
        addItems()
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
        addChild(settingsButton)
        addChild(cardTable)
        addChild(displayBoard)
        addChild(pauseButton)
        addChild(cancelMoveButton)
        addChild(restartButton)
    }
}


final class CardTable: SKNode {
    private let scaledSize: CGSize
    private var cards: [Card] = []
    private var openedCards: [Card] = []
    private let cardNames = [
        "Slot 1", "Slot 2", "Slot 3", "Slot 4",
        "Slot 5", "Slot 6", "Slot 7", "Slot 8"
    ]

    init(scaledSize: CGSize) {
        self.scaledSize = scaledSize
        super.init()
        setupCollectionCards()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionCards() {
        let rows = 4
        let columns = 4
        let spacing: CGFloat = 10

        var cardPairs: [(name: String, id: Int)] = []
        for (i, name) in cardNames.enumerated() {
            cardPairs.append((name, i))
            cardPairs.append((name, i))
        }
        cardPairs.shuffle()

        // Центрируем сетку
        let buttonSize = scaledSize
        let totalWidth = CGFloat(columns) * buttonSize.width + CGFloat(columns - 1) * spacing
        let totalHeight = CGFloat(rows) * buttonSize.height + CGFloat(rows - 1) * spacing
        let startX = -totalWidth / 2 + buttonSize.width / 2
        let startY = totalHeight / 2 - buttonSize.height / 2

        for row in 0..<rows {
            for col in 0..<columns {
                let idx = row * columns + col
                let info = cardPairs[idx]
                let card = Card(frontImageName: info.name, width: buttonSize.width, height: buttonSize.height, cardId: info.id)
                card.position = CGPoint(
                    x: startX + CGFloat(col) * (buttonSize.width + spacing),
                    y: startY - CGFloat(row) * (buttonSize.height + spacing)
                )
                card.action = { [weak self, weak card] in
                    guard let self = self, let card = card else { return }
                    self.cardTapped(card)
                }
                addChild(card)
                cards.append(card)
            }
        }
    }

    private func cardTapped(_ card: Card) {
        guard !card.isOpen, !card.isMatched, openedCards.count < 2 else { return }
        card.showFront()
        
        // Нативный системный звук (click)
        AudioServicesPlaySystemSound(1104)
        
        // Вибрация (легкий тактильный отклик)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        // Визуальный эффект (если хочешь)
        showTapEffect(on: card)
        
        openedCards.append(card)

        if openedCards.count == 2 {
            let first = openedCards[0]
            let second = openedCards[1]
            if first.cardId == second.cardId {
                first.isMatched = true
                second.isMatched = true
                let fade = SKAction.fadeOut(withDuration: 0.3)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([fade, remove])
                first.run(sequence)
                second.run(sequence)
                openedCards.removeAll()
                checkWin()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    first.showBack()
                    second.showBack()
                    self?.openedCards.removeAll()
                }
            }
        }
    }

    private func checkWin() {
        if cards.allSatisfy({ $0.isMatched }) {
            // Победа! Можно вызвать делегат или замыкание для перехода к WinScene
            print("You win!")
        }
    }

    private func showTapEffect(on card: Card) {
        // Пример: вспышка (scale + fade)
        let flash = SKShapeNode(circleOfRadius: card.size.width / 2)
        flash.position = .zero
        flash.fillColor = .yellow
        flash.strokeColor = .clear
        flash.alpha = 0.5
        flash.zPosition = 10
        card.addChild(flash)
        
        let scale = SKAction.scale(to: 1.5, duration: 0.2)
        let fade = SKAction.fadeOut(withDuration: 0.2)
        let remove = SKAction.removeFromParent()
        let group = SKAction.group([scale, fade])
        let sequence = SKAction.sequence([group, remove])
        flash.run(sequence)
    }
}






