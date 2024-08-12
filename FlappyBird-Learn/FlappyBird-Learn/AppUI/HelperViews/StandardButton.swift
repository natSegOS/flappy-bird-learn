//
//  StandardButton.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

struct StandardButton: View {
    let text: String
    
    let backgroundColor: Color
    let textColor: Color
    
    let action: () -> Void
    
    // TODO: allow custom font
    init(_ text: String, backgroundColor: Color, textColor: Color = .white, action: @escaping () -> Void) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ResizableText(text)
                .foregroundStyle(textColor)
                .padding()
                .frame(maxWidth: UIScreen.size.width * 0.8)
                .background(
                    Capsule(style: .continuous)
                        .foregroundStyle(backgroundColor)
                )
        }
    }
}

#Preview {
    StandardButton("Tap Me", backgroundColor: .blue) { }
}
