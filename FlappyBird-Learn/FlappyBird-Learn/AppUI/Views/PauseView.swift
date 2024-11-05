//
//  PauseView.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

// TODO: pause music and replay it

/* NOTES:
 - pause the game
 */

struct PauseView: View {
    @ObservedObject var viewModel = PauseViewModel()
    
    private var isPaused: Binding<Bool>
    private var shouldRestart: Binding<Bool>
    private var isMusicPaused: Binding<Bool>
    
    init(isPaused: Binding<Bool>, shouldRestart: Binding<Bool>, isMusicPaused: Binding<Bool>) {
        self.isPaused = isPaused
        self.shouldRestart = shouldRestart
        self.isMusicPaused = isMusicPaused
        
        self.isMusicPaused.wrappedValue = true
    }
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(spacing: 20) {
                Text("Paused")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                
                StandardButton("Resume", backgroundColor: .green) {
                    isPaused.wrappedValue = false
                    shouldRestart.wrappedValue = false
                    isMusicPaused.wrappedValue = false
                }
                
                StandardButton("Restart", backgroundColor: .yellow) {
                    isPaused.wrappedValue = false
                    shouldRestart.wrappedValue = true
                }
                
                StandardButton("Home", backgroundColor: .blue) {
                    viewModel.goToHome()
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PauseView(isPaused: .constant(true), shouldRestart: .constant(true), isMusicPaused: .constant(true))
}
