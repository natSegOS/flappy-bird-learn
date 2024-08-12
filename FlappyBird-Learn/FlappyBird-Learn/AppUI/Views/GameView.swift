//
//  GameView.swift
//  FlappyBird
//
//  Created by Nathan on 8/6/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    
    @State private var showDeathView = false
    @State private var showPauseView = false
    @State private var shouldRestart = true
    
    var body: some View {
        ZStack {
            Color.blue
            
            // Bird
            Circle()
                .frame(width: viewModel.model.bird.render.width,
                       height: viewModel.model.bird.render.height
                )
                .position(x: viewModel.model.bird.render.origin.x,
                          y: viewModel.model.bird.render.origin.y
                )
                .rotationEffect(viewModel.model.bird.rotation)
                .colorEffect(
                    ShaderLibrary.colorBird(
                        .color(Preferences.shared.birdColor)
                    )
                )
            
            // Pillars
            ForEach(viewModel.model.pillars, id: \.self) { pillar in
                RoundedRectangle(cornerRadius: 6)
                    .fill(.green)
                    .frame(width: pillar.topRender.width,
                           height: pillar.topRender.height
                    )
                    .position(x: pillar.topRender.origin.x,
                              y: pillar.topRender.origin.y
                    )

                RoundedRectangle(cornerRadius: 6)
                    .fill(.green)
                    .frame(width: pillar.bottomRender.width,
                           height: pillar.bottomRender.height
                    )
                    .position(x: pillar.bottomRender.origin.x,
                              y: pillar.bottomRender.origin.y
                    )
            }
            
            // Score
            Text("Score: \(viewModel.model.score)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.top, 50)
                .position(x: UIScreen.size.width / 2, y: 50)
            
            // Pause
            Button {
                viewModel.didStartGame = false
                showPauseView = true
            } label: {
                Circle()
            }
            .foregroundStyle(.gray)
            .frame(width: 75, height: 75)
            .position(x: UIScreen.size.width - 75 * 0.6,
                      y: 75 * 0.6
            )
            
            if showPauseView {
                PauseView(isPaused: $showPauseView, shouldRestart: $shouldRestart)
            }
            
            if !viewModel.didStartGame && !showPauseView {
                Rectangle()
                    .fill(.black.opacity(0.75))
                    .overlay(
                        Text("Tap to Start")
                            .font(.title2)
                            .foregroundStyle(.white)
                    )
            }
            
            if viewModel.model.isGameOver {
                DeathView(finalScore: viewModel.model.score, showDeathView: $viewModel.model.isGameOver, shouldRestart: $shouldRestart)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            guard !viewModel.model.isGameOver else { return }
            
            guard viewModel.didStartGame else {
                if shouldRestart {
                    viewModel.startGame()
                } else {
                    viewModel.didStartGame = true
                }
                
                return
            }
            
            viewModel.birdJump()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameView()
}
