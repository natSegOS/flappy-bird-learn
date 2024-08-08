//
//  GameView.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct GameView: View {
    @State var color = Color.blue
    
    var body: some View {
        Rectangle()
            .colorEffect(
                ShaderLibrary.colorBird(
                    .color(.blue)
                )
            )
    }
}

#Preview {
    let model = GameView()
    for i in 1...5 {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTime(i)*5 + 5) {
            model.color = Color(cgColor: CGColor(red: CGFloat(Double.random(0, 1)), green: CGFloat(Double.random(0, 1)), blue: CGFloat(Double.random(0, 1)), alpha: 1))
        }
    }
}
