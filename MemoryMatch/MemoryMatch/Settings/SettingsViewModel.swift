//
//  SettingsViewModel.swift
//  MemoryMatch
//
//  Created by Вадим Игнатенко on 18.05.25.
//

import Foundation


enum SettingsActions {
    case audio
    case vibration
    case back
}

protocol SettingsViewModelProtocol {
    var adudioOn: Bool { get set }
    var vibrationsOn: Bool { get set }
    
    func toggleAudio()
    func toggleVibrations()
    func backInTheGame()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    var adudioOn: Bool = false
    var vibrationsOn: Bool = false
    
    func toggleAudio() {
        
    }
    
    func toggleVibrations() {
        
    }
    
    func backInTheGame() {
        
    }
    
    
}
