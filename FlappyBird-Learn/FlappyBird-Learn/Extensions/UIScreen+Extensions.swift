//
//  UIScreen+Extensions.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - allows for convenient access to the device's screen size in pixels
 */

extension UIScreen {
    static var size: CGSize { UIScreen.main.bounds.size }
}
