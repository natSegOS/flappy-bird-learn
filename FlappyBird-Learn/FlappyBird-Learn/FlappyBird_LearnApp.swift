//
//  FlappyBird_LearnApp.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - this is where the app starts; the @main decorator tells Swift this is the start of the program
 - navigator keeps track of what screen the user is on
 - if you want to customize how the navigation in the app works, look for tutorials on NavigationStack
 */

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
