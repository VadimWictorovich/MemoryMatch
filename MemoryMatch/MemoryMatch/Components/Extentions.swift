//
//  Extentions.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import SpriteKit

extension SKSpriteNode {
    func scaleToFitScreen(scene: SKScene) {        
        let aspectRatio = self.size.width / self.size.height
        let screenAspectRatio = scene.size.width / scene.size.height
        
        if screenAspectRatio > aspectRatio {
            self.size.width = scene.size.width
            self.size.height = scene.size.width / aspectRatio
        } else {
            self.size.height = scene.size.height
            self.size.width = scene.size.height * aspectRatio
        }
    }

    func fitToScreen(_ screenSize: CGSize) {
        guard let texture = self.texture else { return }
        let imageAspect = texture.size().width / texture.size().height
        let screenAspect = screenSize.width / screenSize.height

        if screenAspect > imageAspect {
            self.size.height = screenSize.height
            self.size.width = screenSize.height * imageAspect
        } else {
            self.size.width = screenSize.width
            self.size.height = screenSize.width / imageAspect
        }
    }
}

extension CGSize {
    static let designSize = CGSize(width: 1080, height: 2400)
    
    func scaleToScreenWidth(_ screenSize: CGSize) -> CGSize {
        let scale = screenSize.width / Self.designSize.width
        return CGSize(width: self.width * scale, height: self.height * scale)
    }
    
    static func scaled(width: CGFloat, height: CGFloat, screenSize: CGSize) -> CGSize {
        CGSize(width: width, height: height).scaleToScreenWidth(screenSize)
    }
}

import SpriteKit

extension CGPoint {
    static func relative(
        xPercent: CGFloat,
        yPercent: CGFloat,
        sceneSize: CGSize
    ) -> CGPoint {
        return CGPoint(
            x: sceneSize.width * xPercent,
            y: sceneSize.height * yPercent
        )
    }

    static func centered(
        yPercent: CGFloat,
        sceneSize: CGSize
    ) -> CGPoint {
        return CGPoint(
            x: sceneSize.width * 0.5,
            y: sceneSize.height * yPercent
        )
    }

    static func middle(
        xPercent: CGFloat,
        sceneSize: CGSize
    ) -> CGPoint {
        return CGPoint(
            x: sceneSize.width * xPercent,
            y: sceneSize.height * 0.5
        )
    }
}

