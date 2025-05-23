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
    
    private lazy var moviesValue = 0 {
        didSet {
            moviesLabel.text = "MOVIES: \(moviesValue)"
        }
    }
    
    private var timer: Timer?
    private var seconds = 0 {
        didSet {
            timerLabel.text = createTimeValue()
        }
    }
        
    private var resultMoviesValue = ""
    private var resultTimeValue = ""
    
    private lazy var displayBoard: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "board")
        let view = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 973, height: 120, screenSize: self.size)
        view.size = scaledSize
        view.position = .centered(yPercent: 0.81, sceneSize: self.size)
        view.zPosition = 1
        return view
    }()
    
    private lazy var moviesLabel: SKLabelNode = {
        let view = SKLabelNode(text: "MOVIES: 0")
        view.fontName = UIFont.boldSystemFont(ofSize: 40).fontName
        view.fontSize = 18
        view.fontColor = .white
        view.position = .relative(xPercent: 0.23, yPercent: 0.8015, sceneSize: self.size)
        view.zPosition = 2
        return view
    }()
    
    private lazy var timerLabel: SKLabelNode = {
        let view = SKLabelNode(text: "TIME: 00:00")
        view.fontName = UIFont.boldSystemFont(ofSize: 40).fontName
        view.fontSize = 18
        view.fontColor = .white
        view.position = .relative(xPercent: 0.77, yPercent: 0.8015, sceneSize: self.size)
        view.zPosition = 2
        return view
    }()
    
    private lazy var settingsButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Settings", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            guard let self else { return }
            self.showSettings()
        }
        view.position = .relative(xPercent: 0.14, yPercent: 0.89, sceneSize: self.size)
        view.zPosition = 1
        return view
    }()
    
    private lazy var cardTable: CardTable = {
        let cardSize = CGSize.scaled(width: 220, height: 220, screenSize: self.size)
        let table = CardTable(scaledSize: cardSize)
        table.actionHandler = { [weak self] action in
            guard let self else { return }
            switch action {
            case .updateMovies:
                self.moviesValue += 1
            case .showYouWin:
                self.stopTimer()
                self.resultMoviesValue = "MOVIES: \(String(self.moviesValue))"
                self.resultTimeValue = self.createTimeValue()
                self.showYouWin()
            }
        }
        table.position = CGPoint(x: frame.midX, y: frame.midY)
        return table
    }()
    
    private lazy var pauseButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Pause", width: scaledSize.width, height: scaledSize.height)
        view.position = .relative(xPercent: 0.14, yPercent: 0.18, sceneSize: self.size)
        view.zPosition = 1
        return view
    }()
    
    private lazy var cancelMoveButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Left", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.viewModel.acttionHandler(.cancelMove)
        }
        view.position = .centered(yPercent: 0.18, sceneSize: self.size)
        view.zPosition = 1
        return view
    }()
    
    private lazy var restartButton: DefaultButton = {
        let scaledSize = CGSize.scaled(width: 121, height: 121, screenSize: self.size)
        let view = DefaultButton(nameImage: "Undo", width: scaledSize.width, height: scaledSize.height)
        view.action = { [weak self] in
            self?.viewModel.acttionHandler(.restart)
        }
        view.position = .relative(xPercent: 0.86, yPercent: 0.18, sceneSize: self.size)
        view.zPosition = 1
        return view
    }()
    
    private lazy var background: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_2")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        sprite.scaleToFitScreen(scene: self)
        sprite.zPosition = -1
        sprite.isUserInteractionEnabled = false
        return sprite
    }()
    
    private lazy var setings: Settings = {
        let view = Settings(screenSize: self.size)
        view.actionHandler = { [weak self] action in
            switch action {
            case .back:
                view.removeFromParent()
            case .sound:
                self?.viewModel.acttionHandler(.soundToggle)
            case .vibration:
                self?.viewModel.acttionHandler(.vibroToggle)
            }
        }
        view.position = .zero
        return view
    }()
    
    private lazy var youWin: YouWinNode = {
        let view = YouWinNode(screenSize: self.size, movies: resultMoviesValue, time: resultTimeValue)
        view.actionHandler = { [weak self] action in
            switch action {
            case .restart:
                self?.viewModel.acttionHandler(.restart)
            case .menu:
                self?.viewModel.acttionHandler(.cancelMove)
            }
        }
        view.position = .zero
        return view
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
        viewModel.setupActions()
        startTimer()
    }
    
    private func startTimer() {
        seconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.seconds += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func createTimeValue() -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        let value = String(format: "TIME: %02d:%02d", minutes, remainingSeconds)
        return value
    }
    
    private func showSettings() {
        addChild(setings)
    }
    
    private func showYouWin() {
        addChild(youWin)
    }
    
    private func addItems() {
        addChild(background)
        addChild(settingsButton)
        addChild(cardTable)
        addChild(displayBoard)
        addChild(pauseButton)
        addChild(cancelMoveButton)
        addChild(restartButton)
        addChild(moviesLabel)
        addChild(timerLabel)
    }
}

//MARK: - Card Table
final class CardTable: SKNode {
    private let scaledSize: CGSize
    private var cards: [Card] = []
    private var openedCards: [Card] = []
    private let cardNames = [
        "Slot 1", "Slot 2", "Slot 3", "Slot 4",
        "Slot 5", "Slot 6", "Slot 7", "Slot 8"
    ]
    
    enum ActionsCardTable {
        case updateMovies
        case showYouWin
    }
    var actionHandler: (ActionsCardTable) -> Void = { _ in }

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
        
        showTapEffect(on: card)
        
        openedCards.append(card)

        if openedCards.count == 2 {
            actionHandler(.updateMovies)
            
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
            actionHandler(.showYouWin)
        }
    }

    private func showTapEffect(on card: Card) {
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


// MARK: - Settings
final class Settings: SKNode {
    
    var screenSize: CGSize
    private lazy var scaledSize = CGSize.scaled(width: 150, height: 150, screenSize: screenSize)
    
    enum Actions {
        case back
        case sound
        case vibration
    }
    var actionHandler: ((Actions) -> Void) = { _ in }
        
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        super.init()
        
        addItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var background: SKSpriteNode = {
        let sprite = SKSpriteNode(color: UIColor(white: 0, alpha: 0.5), size: screenSize)
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        sprite.zPosition = 100
        return sprite
    }()
    
    private lazy var board: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "Frame 2")
        let sprite = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 664, height: 771, screenSize: screenSize)
        sprite.size = scaledSize
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        sprite.zPosition = 101
        return sprite
    }()
    
    private lazy var onOffSound: DefaultButton = {
        let view = DefaultButton(
            nameImage: SoundVibrationManager.isSoundEnabled ? "Speaker" : "Mute Sound",
            width: scaledSize.width,
            height: scaledSize.height
        )
        view.action = { [weak self] in
            self?.actionHandler(.sound)
            self?.updateIcon()
        }
        view.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 70)
        view.zPosition  = 102
        return view
    }()
    
    private lazy var onOffVibro: DefaultButton = {
        let view = DefaultButton(
            nameImage: SoundVibrationManager.isVibrationEnabled ? "Vibro" : "NoVibro",
            width: scaledSize.width,
            height: scaledSize.height
        )
        view.action = { [weak self] in
            self?.actionHandler(.vibration)
            self?.updateIcon()
        }
        view.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.zPosition = 102
        return view
    }()
    
    private lazy var backButton: DefaultButton = {
        let view = DefaultButton(
            nameImage: "Left",
            width: scaledSize.width,
            height: scaledSize.height
        )
        view.action = { [weak self] in
            self?.actionHandler(.back)
        }
        view.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 70)
        view.zPosition = 102
        return view
    }()
    
    private func addItems() {
        addChild(background)
        addChild(board)
        addChild(onOffSound)
        addChild(onOffVibro)
        addChild(backButton)
    }
    
    private func updateIcon() {
        onOffSound.nameForImage = SoundVibrationManager.isSoundEnabled ?  "Speaker" : "Mute Sound"
        onOffVibro.nameForImage = SoundVibrationManager.isVibrationEnabled ? "Vibro" : "NoVibro"
    }
}

// MARK: - YOU WIN
final class YouWinNode: SKNode {
    
    var screenSize: CGSize
    var moviesValue: String
    var timerValue: String
    private lazy var scaledSizeForButton = CGSize.scaled(width: 121, height: 121, screenSize: screenSize)
    
    enum Actions {
        case restart
        case menu
    }
    var actionHandler: ((Actions) -> Void) = { _ in }
        
    init(screenSize: CGSize, movies: String, time: String) {
        self.screenSize = screenSize
        self.moviesValue = movies
        self.timerValue = time
        super.init()
        
        addItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var background: SKSpriteNode = {
        let sprite = SKSpriteNode(color: UIColor(white: 0, alpha: 0.8), size: screenSize)
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        sprite.zPosition = 100
        return sprite
    }()
    
    private lazy var secondBackground: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "bg_1_1")
        let sprite = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 2400, height: 2400, screenSize: screenSize)
        sprite.size = scaledSize
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        sprite.zPosition = 101
        return sprite
    }()
    
    private lazy var board: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "Frame 1")
        let sprite = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 869, height: 462, screenSize: screenSize)
        sprite.size = scaledSize
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 95)
        sprite.zPosition = 102
        return sprite
    }()
    
    private lazy var youWin: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "you win")
        let sprite = SKSpriteNode(texture: texture)
        let scaledSize = CGSize.scaled(width: 1000, height: 1000, screenSize: screenSize)
        sprite.size = scaledSize
        sprite.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 50)
        sprite.zPosition = 103
        return sprite
    }()
    
    private lazy var moviesLabel: SKLabelNode = {
        let view = SKLabelNode(text: moviesValue)
        view.fontName = UIFont.boldSystemFont(ofSize: 40).fontName
        view.fontSize = 18
        view.fontColor = .white
        view.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 115)
        view.zPosition = 104
        return view
    }()
    
    private lazy var timerLabel: SKLabelNode = {
        let view = SKLabelNode(text: timerValue)
        view.fontName = UIFont.boldSystemFont(ofSize: 40).fontName
        view.fontSize = 18
        view.fontColor = .white
        view.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 135)
        view.zPosition = 104
        return view
    }()
    
    private lazy var restartButton: DefaultButton = {
        let view = DefaultButton(
            nameImage: "Undo",
            width: scaledSizeForButton.width,
            height: scaledSizeForButton.height
        )
        view.action = { [weak self] in
            self?.actionHandler(.restart)
        }
        view.position = CGPoint(x: screenSize.width/2 - 27, y: screenSize.height/2 - 220)
        view.zPosition  = 102
        return view
    }()
    
    private lazy var menuButton: DefaultButton = {
        let view = DefaultButton(
            nameImage: "Menu",
            width: scaledSizeForButton.width,
            height: scaledSizeForButton.height
        )
        view.action = { [weak self] in
            self?.actionHandler(.menu)
        }
        view.position = CGPoint(x: screenSize.width/2 + 27, y: screenSize.height/2 - 220)
        view.zPosition  = 102
        return view
    }()
    
    private func addItems() {
        addChild(background)
        addChild(secondBackground)
        addChild(board)
        addChild(restartButton)
        addChild(menuButton)
        addChild(youWin)
        addChild(moviesLabel)
        addChild(timerLabel)
    }
}






