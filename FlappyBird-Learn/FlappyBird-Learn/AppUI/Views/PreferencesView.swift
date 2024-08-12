//
//  PreferencesView.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel = PreferencesViewModel()
    
    let presetBirdColors: [Color] = [.yellow, .red, .blue, .green]
    var showPreferences: Binding<Bool>
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Volume")
                        .font(.title2)
                        .padding(.bottom, 5)
                    
                    Slider(value: $viewModel.model.volume, in: 0...1, step: 0.1) {
                        Text("Volume")
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
                
                // Bird Color Picker
                VStack(alignment: .leading) {
                    Text("Bird Color")
                        .font(.title2)
                        .padding(.bottom, 5)
                    
                    HStack {
                        ForEach(presetBirdColors, id: \.self) { color in
                            Button {
                                viewModel.setBirdColor(to: color)
                            } label: {
                                Circle()
                                    .fill(color)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(viewModel.model.birdColor == color
                                                    ? .black
                                                    : .clear,
                                                    lineWidth: 4)
                                    )
                            }
                            .padding(5)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                StandardButton("Done", backgroundColor: .blue) {
                    viewModel.savePreferences()
                    showPreferences.wrappedValue = false
                }
                .padding(.bottom, 50)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    PreferencesView(showPreferences: Binding.constant(true))
}
