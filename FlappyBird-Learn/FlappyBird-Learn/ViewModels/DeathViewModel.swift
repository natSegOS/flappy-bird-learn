//
//  DeathViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Foundation

class DeathViewModel {
    let finalScore: Int
    
    init(finalScore: Int) {
        self.finalScore = finalScore
    }
    
    func goToHome() {
        Navigator.shared.navigate(to: .home)
    }
}
