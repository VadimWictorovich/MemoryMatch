//
//  MainMenuViewModel.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation


enum Actions {
    case startGame
    case privacyPolicy
}

protocol MainMenuViewModelProtocol: AnyObject {
    var actionHandler: (Actions) -> Void { get set }
    
    func startGame()
    func openPrivacyPolicy()
}

final class MainMenuViewModel: MainMenuViewModelProtocol {
    
    var coordinator: CoordinatorProtocol
    var actionHandler: (Actions) -> Void = { _ in }
    
    init (coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func startGame() {
        coordinator.showGameplay()
    }
    
    func openPrivacyPolicy() {
        coordinator.showPrivacyPolicy()
    }
}
