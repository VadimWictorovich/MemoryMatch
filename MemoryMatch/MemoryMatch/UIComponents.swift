//
//  UIComponents.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation
import SpriteKit

class DefaultButton: SKSpriteNode {
    
    var action: (() -> Void) = { }
    
    init(nameImage: String, width: CGFloat = 121, height: CGFloat = 121) {
        let texture = SKTexture(imageNamed: nameImage)
        let size = CGSize(width: width, height: height)
        
        super.init(texture: texture, color: .clear, size: size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            let rect = CGRect(
                x: -self.size.width / 2,
                y: -self.size.height / 2,
                width: self.size.width,
                height: self.size.height
            )
            print("touchPoint:", touchPoint)
            print("rect:", rect)
            if rect.contains(touchPoint) {
                print("contains!")
                action()
            } else {
                print("NOT contains!")
            }
        }
    }
}

final class Card: DefaultButton {
    var isOpen = false
    var isMatched = false
    let cardId: Int
    let frontImageName: String

    init(frontImageName: String, width: CGFloat, height: CGFloat, cardId: Int) {
        self.cardId = cardId
        self.frontImageName = frontImageName
        super.init(nameImage: "Slot", width: width, height: height) // "Slot" — рубашка
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showFront() {
        self.texture = SKTexture(imageNamed: frontImageName)
        isOpen = true
    }

    func showBack() {
        self.texture = SKTexture(imageNamed: "Slot")
        isOpen = false
    }
}
