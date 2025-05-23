//
//  Coordinator.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit
import SafariServices
import UIKit


protocol CoordinatorProtocol: AnyObject {
    func start()
    func showSplashScreen()
    func showMainMenu()
    func showGameplay()
    func showPrivacyPolicy()
}

final class Coordinator: CoordinatorProtocol {
    private weak var viewController: GameViewController?
    
    init(viewController: GameViewController) {
        self.viewController = viewController
    }
    
    func start() {
        showSplashScreen()
    }
    
    func showSplashScreen() {
        guard let view = viewController?.view as? SKView else { return }
        let scene = SplashScreenScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        
        scene.simulateLoading { [weak self] in
            self?.showMainMenu()
        }
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
        let viewModel = GameplayViewModel(coordinator: self)
        let scene = GameplayScene(size: view.bounds.size, viewModel: viewModel)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func showPrivacyPolicy() {
        guard let url = URL(string: "https://github.com/VadimWictorovich/MemoryMatch"),
              let root = viewController else { return }
        
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = .systemBlue
        
        DispatchQueue.main.async {
            root.present(vc, animated: true)
        }
    }
}
