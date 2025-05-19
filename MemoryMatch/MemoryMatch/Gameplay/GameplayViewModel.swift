//
//  GameplayViewModel.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation

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

protocol GameplayViewModelDelegate: AnyObject {
    func didUpdateCards(_ cards: [CardModel])
    func didWinGame()
}

protocol GameplayViewModelProtocol: AnyObject {
    var cards: [CardModel] { get }
    var delegate: GameplayViewModelDelegate? { get set }
    func chooseCard(at index: Int)
    func flipCard()
    func openSettings()
    func pauseGame()
    func cancelMove()
    func restartGame()
    func setup(numbersOfPairsCards: Int)
}

final class GameplayViewModel: GameplayViewModelProtocol {
    
    var cards: [CardModel] = []
    weak var delegate: GameplayViewModelDelegate?
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
        delegate?.didUpdateCards(cards)
        if cards.allSatisfy({ $0.isMatched }) {
            delegate?.didWinGame()
        }
    }
    
    func setup(numbersOfPairsCards: Int) {
        cards = []
        for _ in 1...numbersOfPairsCards {
            let card = CardModel()
            cards += [card, card]
        }
        cards.shuffle()
        delegate?.didUpdateCards(cards)
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


