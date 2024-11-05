//
//  PauseViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine

/* NOTES:
 - handle navigation in the pause view
 - customize functionality as needed
 */

class PauseViewModel: ObservableObject {
    func goToHome() {
        Navigator.shared.navigate(to: .home)
    }
}
