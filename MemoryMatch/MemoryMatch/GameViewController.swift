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
}
