//
//  AutoResizableText.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

/* NOTES:
 - this file's purpose is to create the .autoResizableText() extension so text can be automatically resized more conveniently
 - this extension is used by the ResizableText helper view
 */

struct AutoResizableText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(nil)
            .minimumScaleFactor(0.1)
    }
}

extension Text {
    func autoResizableText() -> some View {
        return self.modifier(AutoResizableText())
    }
}
