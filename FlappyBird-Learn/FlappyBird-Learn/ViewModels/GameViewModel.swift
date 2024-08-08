//
//  GameViewModel.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var model: Game
    
    private var timerSubscription: AnyCancellable?
    
    init() {
        self.model = Game()
        setupPillars()
    }
    
    func setupPillars() {
        model.pillars = [
            Pillar(xPosition: 400, topHeight: 150, bottomHeight: 300),
            Pillar(xPosition: 600, topHeight: 200, bottomHeight: 250)
        ]
    }
    
    func startGame() {
        model.isGameRunning = true
        model.score = 0
        model.birdPosition = Game.defaultBirdPosition
        startTimer()
    }
    
    func stopGame() {
        model.isGameRunning = false
        timerSubscription?.cancel()
    }
    
    func pauseGame() {
        model.isPaused = true
        timerSubscription?.cancel()
    }
    
    func resumeGame() {
        model.isPaused = false
        startTimer()
    }
    
    private func startTimer() {
        guard model.isGameRunning && !model.isPaused else { return }
        
        model.birdPosition.y += 5 // lower bird due to gravity
        
        for i in 0..<model.pillars.count {
            model.pillars[i].xPosition -= 5
        }
        
        checkCollision()
        model.score += 1
    }
    
    func jumpBird() {
        guard model.isGameRunning && !model.isPaused else { return }
        model.birdPosition.y -= 50
    }
    
    private func checkCollision() {
        for pillar in model.pillars {
            let birdFrame = CGRect(x: model.birdPosition.x, y: model.birdPosition.y, width: Game.birdSize.width, height: Game.birdSize.height)
            let topPillarFrame = CGRect(x: pillar.xPosition, y: 0, width: Game.pillarWidth, height: pillar.topHeight)
            let bottomPillarFrame = CGRect(x: pillar.xPosition, y: UIScreen.size.height - pillar.bottomHeight, width: Game.pillarWidth, height: pillar.bottomHeight)
            
            if birdFrame.intersects(topPillarFrame) || birdFrame.intersects(bottomPillarFrame) {
                stopGame()
                return
            }
        }
        
        // check if bird hits ground or ceiling
        if model.birdPosition.y <= 0 || model.birdPosition.y >= UIScreen.size.height {
            stopGame()
        }
    }
    
    func saveScore() {
        let currentHighScore = UserDefaults.standard.integer(forKey: DataStore.kHighScore)
        if model.score > currentHighScore {
            UserDefaults.standard.set(model.score, forKey: DataStore.kHighScore)
        }
    }
}
