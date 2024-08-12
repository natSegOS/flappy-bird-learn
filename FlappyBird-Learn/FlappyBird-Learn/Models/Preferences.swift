//
//  Preferences.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct Preferences {
    static var shared = Preferences()
    
    var birdColor: Color
    var volume: Float
    
    init() {
        volume = UserDefaults.standard.float(forKey: DataStore.kVolume) // TODO: default to 50% volume if not already saved; currently, it defaults to 0%
        
        if let encodedColor = UserDefaults.standard.data(forKey: DataStore.kBirdColor),
           let decodedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: encodedColor) {
            birdColor = Color(decodedColor)
        } else {
            birdColor = .yellow
        }
    }
}
