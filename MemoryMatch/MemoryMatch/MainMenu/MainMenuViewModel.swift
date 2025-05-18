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

struct MainMenuModel{
    let nameImageBackground: String
    let nameImageStartGame: String
    let nameImagePrivacyPolicy: String
}

protocol MainMenuViewModelProtocol {
    func startGame()
    func openPrivacyPolicy()
}

final class MainMenuViewModel: MainMenuViewModelProtocol {
    func startGame() {
        // отправляемся на игру
    }
    
    func openPrivacyPolicy() {
        // открывается окно с любой url вкладкой
    }
    
}
