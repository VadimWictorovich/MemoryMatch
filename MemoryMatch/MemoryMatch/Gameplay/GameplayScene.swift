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
    
    private var collectionCardNames: [String] = [
        "Slot 1", "Slot 2", "Slot 3", "Slot 4", "Slot 5",
        "Slot 6", "Slot 7", "Slot 8", "Slot"
    ]
    
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
        table.position = CGPoint(x: frame.midX, y: frame.midY) // по центру сцены
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
        cardTable.setupCollectionButtons()
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
    
    
    
//    var nameImageDictionary = [String: SKTexture]()
    var nameImageDictionary = [Int: String]()
    var collectionCardNames1: [String] = [
        "Slot 1", "Slot 2", "Slot 3", "Slot 4", "Slot 5",
        "Slot 6", "Slot 7", "Slot 8", "Slot"
    ]
    
    private func identifierImage(for card: CardModel) -> String {
        if nameImageDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(collectionCardNames.count - 1)))
            nameImageDictionary[card.identifier] = collectionCardNames.remove(at: randomIndex)
        }
        
        
        return nameImageDictionary[card.identifier] ?? "?"
    }
    
    
    
//    private func updateView() {
//        for index in buttonCollection.indices {
//            let button = buttonCollection[index]
//            let card = viewModel.cards[index]
//            
//            if card.state == .open {
//                button.nameImage() //открыть карточку
//            } else if card.state == .closed {
//                // тут закрая карточка
//                button.nameImage = card.isMatched ? "matched" : "closed"
//            }
//        }
//    }
}


final class CardTable: SKNode {
    
    private let scaledSize: CGSize
    private var movies = 0
    private var collectionButtons: [DefaultButton] = []
    
    
    
    init(scaledSize: CGSize) {
        self.scaledSize = scaledSize
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionButtons() {
        let rows = 4
        let columns = 4
        let spacing: CGFloat = 10

        // Размер одной кнопки
        let buttonSize = scaledSize

        // Вычисляем смещение, чтобы сетка была по центру CardTable (0,0)
        let totalWidth = CGFloat(columns) * buttonSize.width + CGFloat(columns - 1) * spacing
        let totalHeight = CGFloat(rows) * buttonSize.height + CGFloat(rows - 1) * spacing
        let startX = -totalWidth / 2 + buttonSize.width / 2
        let startY = totalHeight / 2 - buttonSize.height / 2

        for row in 0..<rows {
            for col in 0..<columns {
                let button = DefaultButton(nameImage: "Slot", width: buttonSize.width, height: buttonSize.height)
                let x = startX + CGFloat(col) * (buttonSize.width + spacing)
                let y = startY - CGFloat(row) * (buttonSize.height + spacing)
                button.position = CGPoint(x: x, y: y)
                addChild(button)
                collectionButtons.append(button)
            }
        }
    }
    
}






