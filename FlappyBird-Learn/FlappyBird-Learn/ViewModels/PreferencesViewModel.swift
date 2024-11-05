//
//  PreferencesViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - keep track of preferences and allow the user to change preferences in the Preferences view
- customize functionality as needed
 */

class PreferencesViewModel: ObservableObject {
    @Published var model = Preferences() {
        didSet {
            Preferences.shared = model
        }
    }
    
    func setVolume(to volume: Float) {
        model.volume = volume
    }
    
    func setBirdColor(to color: Color) {
        model.birdColor = color
    }
    
    func savePreferences() {
        UserDefaults.standard.set(model.volume, forKey: DataStore.kVolume)
        
        // Colors are not natively-supported by UserDefaults, so must encode it into a Data object
        if let encodedColor = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(model.birdColor), requiringSecureCoding: false),
           let encoding = Data(base64Encoded: encodedColor) {
            UserDefaults.standard.set(encoding, forKey: DataStore.kBirdColor)
        }
    }
}
