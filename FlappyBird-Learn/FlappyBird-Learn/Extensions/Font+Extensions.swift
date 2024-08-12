//
//  Font+Extensions.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

extension Font {
    static func idealFont(maxFontSize: CGFloat = 20) -> Font {
        let referenceScreenHeight: CGFloat = 844 // Using iPhone 14 Pro for reference; its screen height is 844 pixels
        let idealFontSize = (UIScreen.size.height / referenceScreenHeight) * maxFontSize
        
        return Font.system(size: min(idealFontSize, maxFontSize), weight: .regular, design: .default)
    }
}
