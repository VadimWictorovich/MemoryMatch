//
//  Extentions.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

extension SKSpriteNode {
    func scaleToFitScreen() {
        guard let scene = self.scene else { return }
        
        let aspectRatio = self.size.width / self.size.height
        let screenAspectRatio = scene.size.width / scene.size.height
        
        if screenAspectRatio > aspectRatio {
            // Экран шире чем изображение
            self.size.width = scene.size.width
            self.size.height = scene.size.width / aspectRatio
        } else {
            // Экран уже чем изображение
            self.size.height = scene.size.height
            self.size.width = scene.size.height * aspectRatio
        }
    }

    /// Вписывает изображение в экран с сохранением пропорций (cover)
    func fitToScreen(_ screenSize: CGSize) {
        guard let texture = self.texture else { return }
        let imageAspect = texture.size().width / texture.size().height
        let screenAspect = screenSize.width / screenSize.height

        if screenAspect > imageAspect {
            // Экран шире, подгоняем по высоте
            self.size.height = screenSize.height
            self.size.width = screenSize.height * imageAspect
        } else {
            // Экран уже, подгоняем по ширине
            self.size.width = screenSize.width
            self.size.height = screenSize.width / imageAspect
        }
    }
}

extension CGSize {
    /// Базовый размер макета (Figma)
    static let designSize = CGSize(width: 1080, height: 2400)
    
    /// Масштабирование по ширине экрана
    func scaleToScreenWidth(_ screenSize: CGSize) -> CGSize {
        let scale = screenSize.width / Self.designSize.width
        return CGSize(width: self.width * scale, height: self.height * scale)
    }
    
    static func scaled(width: CGFloat, height: CGFloat, screenSize: CGSize) -> CGSize {
        CGSize(width: width, height: height).scaleToScreenWidth(screenSize)
    }
}
