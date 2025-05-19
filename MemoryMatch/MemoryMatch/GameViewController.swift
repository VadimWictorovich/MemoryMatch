//
//  GameViewController.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    enum GameState {
        case mainMemu
        case gameplay
        case pause
        case win
        case openSettings
    }
    
    private var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCoordinator()
    }
    
    private func setupView() {
        guard let view = self.view as? SKView else { return }
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }
    
    private func setupCoordinator() {
        coordinator = Coordinator(viewController: self)
        coordinator?.start()
    }
    
    

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}
