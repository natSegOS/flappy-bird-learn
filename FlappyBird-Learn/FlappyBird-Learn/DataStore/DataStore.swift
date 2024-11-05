//
//  DataStore.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Foundation

/* NOTES
 - allows for easy-access to the keys you will be using to store data; this makes it less likely for you to forget key names or make spelling errors when using them in multiple places in your code
 - using the letter "k" at the beginning of variables representing keys of some kind is standard practice but not required
 */

enum DataStore {
    static let kHighScore = "high-score"
    static let kVolume = "volume"
    static let kBirdColor = "bird-color"
}
