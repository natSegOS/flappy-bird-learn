//
//  Preferences.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - represents the user's preferences that are used throughout the app; in this case the bird color and the volume of sounds
 */

struct Preferences {
    static let defaultVolume = 0.5 // decimal representation of percentages
    static let defaultBirdColor = Color.yellow
    
    static var shared = Preferences() // singleton access to preferences for convenience
    
    var birdColor: Color
    var volume: Float
    
    // checks if the user has saved preferences and if so, loads them; otherwise uses default preferences
    init() {
        volume = UserDefaults.standard.float(forKey: DataStore.kVolume) // TODO: default to 50% volume if not already saved; currently, it defaults to 0%
        
        if let encodedColor = UserDefaults.standard.data(forKey: DataStore.kBirdColor),
           let decodedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: encodedColor) {
            birdColor = Color(decodedColor)
        } else {
            birdColor = Preferences.defaultBirdColor
        }
    }
}
