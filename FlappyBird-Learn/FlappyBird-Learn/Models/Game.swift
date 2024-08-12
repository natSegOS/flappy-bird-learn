//
//  Game.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct Game {
    static let defaultBirdPosition = CGPoint(x: Bird.size.width * 1.5, y: 0.5 * (1 - Bird.size.height))
    
    var bird = Bird(position: defaultBirdPosition, rotation: .degrees(0))
    var pillars = [Pillar]()
    var score = 0
    var isGameOver = false
}
