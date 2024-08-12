//
//  PauseViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine

class PauseViewModel: ObservableObject {
    func goToHome() {
        Navigator.shared.navigate(to: .home)
    }
}
