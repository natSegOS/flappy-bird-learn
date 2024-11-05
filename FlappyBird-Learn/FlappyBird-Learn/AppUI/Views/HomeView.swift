//
//  HomeView.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - viewModel is responsible for the functionality like fetching the high score and navigating to the next screen
 - showPreferences keeps track of whether to show the preferences view
 - StandardButton is a custom button for convenient re-use across the app
 - Feel free to customize as you see fit; HackingWithSwift has good tutorials on SwiftUI
 */

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    @State private var showPreferences = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Flappy Bird")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack {
                    StandardButton("Start Game", backgroundColor: .blue) {
                        // navigate to game view using viewModel
                        viewModel.navigateToGame()
                    }
                    
                    StandardButton("Preferences", backgroundColor: .gray) {
                        // toggle the show preferences pop-up
                        showPreferences = true
                    }
                }
            }
            
            if showPreferences {
                // only show the preferences pop-up when showPreferences is true and allow the preferences view control over the variable so the variable can be set to false when the user wants to close the preferences view
                PreferencesView(showPreferences: $showPreferences)
            }
        }
    }
}

#Preview {
    HomeView()
}
