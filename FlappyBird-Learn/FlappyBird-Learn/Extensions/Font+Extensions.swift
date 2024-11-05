//
//  Font+Extensions.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import SwiftUI

/* NOTES:
 - this file allows for a universal text size experience, so text appears the same relative to screen size on all devices; this way it isn't too small or too big for a given device
 */

extension Font {
    // transforms how text would look on an iPhone 14 Pro to how it should look on any other device. I thought 20 pixels was a decent-looking font size on an iPhone 14 Pro; feel free to change this value. Make sure you are using an iPhone 14 Pro or a simulation of it when choosing a nice font size though since this function computes relative to the iPhone 14 Pro
    // if you want to use a different iPhone model as reference, change the referenceScreenHeight value to the screen height in pixels of the model you are using
    static func idealFont(maxFontSize: CGFloat = 20) -> Font {
        let referenceScreenHeight: CGFloat = 844 // Using iPhone 14 Pro for reference; its screen height is 844 pixels
        let idealFontSize = (UIScreen.size.height / referenceScreenHeight) * maxFontSize
        
        return Font.system(size: min(idealFontSize, maxFontSize), weight: .regular, design: .default)
    }
}
