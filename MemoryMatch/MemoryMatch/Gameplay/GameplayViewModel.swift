//
//  GameplayViewModel.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation


//struct GameplayModel {
//    let movies: Int
//    let time: String
//    let nameSettingsButton: String
//    let namePauseButton: String
//    let nameCancelMoveButton: String
//    let nameRestartButton: String
//}

struct CardModel {
    enum CardState {
        case open
        case closed
    }
    var state: CardState = .closed
    var isMatched = false
    var identifier: Int
    
    static var identifierNumber = 0

    static func identifierGenerator() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    
    init() {
        self.identifier = CardModel.identifierGenerator()
    }
}

enum GameplayActions {
    case flip
    case settings
    case pause
    case cancelMove
    case restart
}

protocol GameplayViewModelProtocol: AnyObject {
    var cards: [CardModel] { get set }
    
    func chooseCard(at index: Int)
    func flipCard()
    func openSettings()
    func pauseGame()
    func cancelMove()
    func restartGame()
}

final class GameplayViewModel: GameplayViewModelProtocol {
    
    var cards : [CardModel] = []
    
    var indexOfOneAndOnlyFlippedCard: Int?
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched == false {
            
            if let matchingIndex = indexOfOneAndOnlyFlippedCard, matchingIndex != index {
                
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].state = .open
                indexOfOneAndOnlyFlippedCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].state = .closed
                }
                cards[index].state = .open
                indexOfOneAndOnlyFlippedCard = index
            }
        }
    }
    
    func setup(numbersOfPairsCards: Int) {
        for _ in 1..<numbersOfPairsCards {
            let card = CardModel()
            cards += [card, card]
        }
    }
    
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


