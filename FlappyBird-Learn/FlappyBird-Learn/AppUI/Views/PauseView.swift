//
//  PauseView.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct PauseView: View {
    @ObservedObject var viewModel = PauseViewModel()
    
    private var isPaused: Binding<Bool>
    private var shouldRestart: Binding<Bool>
    
    init(isPaused: Binding<Bool>, shouldRestart: Binding<Bool>) {
        self.isPaused = isPaused
        self.shouldRestart = shouldRestart
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
    PauseView(isPaused: .constant(true), shouldRestart: .constant(true))
}
