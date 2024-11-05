//
//  GameView.swift
//  FlappyBird
//
//  Created by Nathan on 8/6/24.
//

import SwiftUI

/* NOTES:
 - displays the game to the user
 - attempts to replicate the game logic in viewModel and show it to the screen
 - for the most part, it seems the actual game logic is fine except for a few things such as making the bird do animations and making sure everything has the correct zIndex, which controls how views overlap each other
 - most issues with the app have to do with incorrect rendering
 */

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    
    @State private var showDeathView = false
    @State private var showPauseView = false
    @State private var shouldRestart = true
    @State private var isMusicPaused = false {
        didSet {
            if isMusicPaused {
                viewModel.backgroundMusicAudioPlayer?.stop()
            } else {
                viewModel.backgroundMusicAudioPlayer?.play()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.blue
            
            // Bird
            // TODO: replace this circle with the image you are using for the bird
            Circle()
                .frame(width: viewModel.model.bird.render.width,
                       height: viewModel.model.bird.render.height
                )
                .position(x: viewModel.model.bird.render.x,
                          y: viewModel.model.bird.render.y
                )
                .zIndex(viewModel.model.bird.render.zIndex)
                .rotationEffect(viewModel.model.bird.rotation)
                .colorEffect(
                    // this code is responsible for coloring the bird
                    // you might consider something similar for coloring the pillars or anything else you want to be able to quickly change the color of
                    ShaderLibrary.colorBird(
                        .color(Preferences.shared.birdColor)
                    )
                )
            
            // Pillars
            ForEach(viewModel.model.pillars, id: \.self) { pillar in
                // Top Section
                ForEach(pillar.topRenders.pieces, id: \.self) { piece in
                    // TODO: replace this capsule with the image you are using for each pillar piece
                    Capsule(style: .continuous)
                        .foregroundStyle(.red)
                        .frame(width: piece.width,
                               height: piece.height)
                        .position(x: piece.x,
                                  y: piece.y)
                        .zIndex(piece.zIndex)
                }
                
                
                // Bottom Section
                ForEach(pillar.bottomRenders.pieces, id: \.self) { piece in
                    Capsule(style: .continuous)
                        .foregroundStyle(.blue)
                        .frame(width: piece.width,
                               height: piece.height)
                        .position(x: piece.x,
                                  y: piece.y)
                        .zIndex(piece.zIndex)
                }
                
                // Top Lip
                Capsule(style: .continuous)
                    .foregroundStyle(.green)
                    .frame(width: pillar.topRenders.lip.width,
                           height: pillar.topRenders.lip.height)
                    .position(x: pillar.topRenders.lip.x,
                              y: pillar.topRenders.lip.y)
                
                // Bottom Lip
                Capsule(style: .continuous)
                    .foregroundStyle(.yellow)
                    .frame(width: pillar.bottomRenders.lip.width,
                           height: pillar.bottomRenders.lip.height)
                    .position(x: pillar.bottomRenders.lip.x,
                              y: pillar.bottomRenders.lip.y)
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
                PauseView(isPaused: $showPauseView, shouldRestart: $shouldRestart, isMusicPaused: $isMusicPaused)
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
