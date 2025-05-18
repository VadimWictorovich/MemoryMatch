//
//  SettingsScene.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

class SettingsScene: SKScene {
    var viewModel: SettingsViewModelProtocol
    var actionHandler: (SettingsActions) -> Void = { _ in }
    
    private lazy var board: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "board")
        let sprite = SKSpriteNode(texture: texture)
        let audioLabel = SKLabelNode(text: "ВКЛЮЧЕН ЗВУК")
        let vibrLabel = SKLabelNode(text: "ВИБРАЦИЯ ВКЛЮЧЕНА")
        let audioBut = DefaultButton(nameImage: "", width: 20)
        audioBut.action = { [weak self] in
            self?.actionHandler(.audio)
        }
        let vibrBut = DefaultButton(nameImage: "", width: 20)
        vibrBut.action = { [weak self] in
            self?.actionHandler(.vibration)
        }
        sprite.addChild(audioLabel)
        sprite.addChild(vibrLabel)
        sprite.addChild(audioBut)
        sprite.addChild(vibrBut)
        return sprite
    }()
    
    private lazy var backButton: DefaultButton = {
        let view = DefaultButton(nameImage: "", width: 200)
        view.action = { [weak self] in
            self?.actionHandler(.back)
        }
        return view
    }()
    
    init(size: CGSize, viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(size: size)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        addItems()
        setupUI()
    }
    
    private func addItems() {
        addChild(board)
        addChild(backButton)
    }
    
    private func setupUI() {
        
    }
    
    
    
    
    

}
