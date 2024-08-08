//
//  Game.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct Game {
    static let pillarWidth = CGFloat(60)
    static let birdSize = CGSize(width: 40, height: 60)
    static let defaultBirdPosition = CGPoint(x: birdSize.width / 2 + 10, y: UIScreen.size.height / 2)
    
    var birdPosition = defaultBirdPosition
    var isGameRunning = false
    var isPaused = false
    var timer: Timer?
    var pillars = [Pillar]()
    var score = 0
}
