//
//  GameplayViewModel.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation


struct GameplayModel {
    let movies: Int
    let time: String
    let nameSettingsButton: String
    let namePauseButton: String
    let nameCancelMoveButton: String
    let nameRestartButton: String
}

enum GameplayActions {
    case flip
    case settings
    case pause
    case cancelMove
    case restart
}

protocol GameplayViewModelProtocol: AnyObject {
    func flipCard()
    func openSettings()
    func pauseGame()
    func cancelMove()
    func restartGame()
}

final class GameplayViewModel: GameplayViewModelProtocol {
    
    func flipCard() {
        
    }
    
    func openSettings() {
        
    }
    
    func pauseGame() {
        
    }
    
    func cancelMove() {
        
    }
    
    func restartGame() {
        
    }
    
}


