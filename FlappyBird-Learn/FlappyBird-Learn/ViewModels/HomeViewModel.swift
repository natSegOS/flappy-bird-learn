//
//  HomeViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine
import SwiftUI

/* NOTES:
 - keep track of high score and handle navigation in the home screen
 - customize functionality as needed
 */

class HomeViewModel: ObservableObject {
    @Published var highScore = 0
    
    init() {
        fetchHighScore()
    }
    
    func fetchHighScore() {
        highScore = UserDefaults.standard.integer(forKey: DataStore.kHighScore)
    }
    
    func navigateToGame() {
        Navigator.shared.navigate(to: .game)
    }
}


