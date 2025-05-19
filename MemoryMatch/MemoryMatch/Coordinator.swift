//
//  Coordinator.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit


protocol CoordinatorProtocol: AnyObject {
    func start()
    func showMainMenu()
    func showGameplay()
    func showSettings()
    func showWinScreen()
    func showPrivacyPolicy()
}


final class Coordinator: CoordinatorProtocol {
    private weak var viewController: GameViewController?
    
    init(viewController: GameViewController) {
        self.viewController = viewController
    }
    
    func start() {
        showMainMenu()
    }
    
    func showMainMenu() {
        guard let view = viewController?.view as? SKView else { return }
        let viewModel = MainMenuViewModel(coordinator: self)
        let scene = MainMenuScene(size: view.bounds.size, viewModel: viewModel)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func showGameplay() {
        guard let view = viewController?.view as? SKView else { return }
        let viewModel = GameplayViewModel()
        let scene = GameplayScene(size: view.bounds.size, viewModel: viewModel)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func showSettings() {
        guard let view = viewController?.view as? SKView else { return }
        let viewModel = SettingsViewModel()
        let scene = SettingsScene(size: view.bounds.size, viewModel: viewModel)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func showWinScreen() {
        guard let view = viewController?.view as? SKView else { return }
        let scene = WinScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func showPrivacyPolicy() {
        
    }
}
