//
//  ResizableText.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

/*
 - This is a custom view that allows text to be resized automatically to the "ideal" font size at any given time
 - this is used by the StandardButton helper view
 */

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
