//
//  HomeView.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Flappy Bird")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button {
                viewModel.navigateToGame()
            } label: {
                Text("Start Game")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(
                        Capsule(style: .continuous)
                    )
            }
            
            Button {
                viewModel.navigateToSettings()
            } label: {
                Text("Settings")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray)
                    .foregroundStyle(.white)
                    .clipShape(
                        Capsule(style: .continuous)
                    )
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
