//
//  HomeView.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

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
                        viewModel.navigateToGame()
                    }
                    
                    StandardButton("Preferences", backgroundColor: .gray) {
                        showPreferences = true
                    }
                }
            }
            
            if showPreferences {
                PreferencesView(showPreferences: $showPreferences)
            }
        }
    }
}

#Preview {
    HomeView()
}
