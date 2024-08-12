//
//  FlappyBird_LearnApp.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

@main
struct FlappyBird_LearnApp: App {
    @ObservedObject var navigator = Navigator.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigator.path) {
                HomeView()
                    .navigationDestination(for: ViewID.self) { viewID in
                        switch viewID {
                        case .home:
                            HomeView()
                            
                        case .game:
                            GameView()
                        }
                    }
            }
        }
    }
}
