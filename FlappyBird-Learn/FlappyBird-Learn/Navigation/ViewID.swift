//
//  ViewID.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Foundation

/* NOTES:
 - each ViewID represents a screen, for example the home screen or the main game screen; you only need IDs for the main screens, not pop-ups or mini-views within the larger main views. For example, if the preferences view is just a pop-up that appears within the home or game screen, it doesn't need its own ViewID
 - feel free to customize as you need
 */

enum ViewID {
    case home
    case game
}
