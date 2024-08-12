//
//  ResizableText.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

struct ResizableText: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.idealFont())
            .autoResizableText()
    }
}

#Preview {
    ResizableText("Hello, World")
}
