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
    var isEnabled = true
    
    init(nameImage: String, width: CGFloat) {
        let texture = SKTexture(imageNamed: nameImage)
        let aspectRatio = texture.size().height / texture.size().width
        let size = CGSize(width: width, height: width * aspectRatio)

        super.init(texture: texture, color: .clear, size: size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            if self.contains(touchPoint) {
                action()
            }
        }
    }
}

enum CardState {
    case open
    case closed
}

final class Card: DefaultButton {
    var state: CardState = .closed
}
