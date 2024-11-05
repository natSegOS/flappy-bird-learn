//
//  DeathView.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct DeathView: View {
    /* NOTES:
     - show death stats
     */
    var viewModel: DeathViewModel
    
    private var showDeathView: Binding<Bool>
    private var shouldRestart: Binding<Bool>
    
    init(finalScore: Int, showDeathView: Binding<Bool>, shouldRestart: Binding<Bool>) {
        self.viewModel = DeathViewModel(finalScore: finalScore)
        self.showDeathView = showDeathView
        self.shouldRestart = shouldRestart
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .padding()
                
                Text("Final Score: \(viewModel.finalScore)")
                    .font(.title)
                    .foregroundStyle(.white)
                
                StandardButton("Replay", backgroundColor: .green) {
                    showDeathView.wrappedValue = false
                    shouldRestart.wrappedValue = true
                }
                
                StandardButton("Home", backgroundColor: .blue) {
                    viewModel.goToHome()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DeathView(finalScore: 0, showDeathView: .constant(true), shouldRestart: .constant(true))
}
