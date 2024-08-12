//
//  GameViewModel.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import AVFoundation
import SwiftUI

class GameViewModel: ObservableObject {
    static let frameRate = 1.0 / 60.0 // 60 frames per second
    
    static let generatePillarPoint = 0.25 // generate pillars when position is at 25% screen width mark
    static let pillarSpeed: CGFloat = 0.1 // 10% of screen width per second
    static let minGapSize = Bird.size.height * 2
    static let maxGapSize = Bird.size.height * 6
    
    static let jumpPower = 0.1 // 10% of screen per second
    static let gravity: CGFloat = 0.1 // 10% of screen height per square second
    
    @Published var model: Game
    
    var birdVelocity: CGFloat = 0
    var didStartGame = false
    
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    private var lastGameUpdateDate = Date.now
    
    init() {
        model = Game()
    }
    
    func startGame() {
        model.isGameOver = false
        model.bird.position = Game.defaultBirdPosition
        model.bird.rotation = .degrees(0)
        model.pillars.removeAll(keepingCapacity: true)
        model.score = 0
        
        birdVelocity = 0
        didStartGame = true
        
        lastGameUpdateDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: GameViewModel.frameRate, repeats: true) { [weak self] timerReference in
            guard let self = self else {
                timerReference.invalidate()
                return
            }
            
            guard let currentDate = self.timer?.fireDate else { return }
            
            let deltaTime = CGFloat(lastGameUpdateDate.distance(to: currentDate))
            self.updateGame(deltaTime: deltaTime)
            self.lastGameUpdateDate = currentDate
        }

        generatePillars()
    }

    func updateGame(deltaTime: CGFloat) {
        guard didStartGame && !model.isGameOver else { return }

        birdVelocity -= GameViewModel.gravity * deltaTime
        model.bird.position.y += birdVelocity * deltaTime

        model.bird.rotation = .degrees(min(max(-birdVelocity * 2, -90), 90))
        
        for index in model.pillars.indices {
            model.pillars[index].xPosition -= GameViewModel.pillarSpeed * deltaTime
        }

        model.pillars.removeAll { $0.xPosition < -Pillar.width }

        checkCollisions()

        if let lastPillar = model.pillars.last, lastPillar.xPosition < GameViewModel.generatePillarPoint {
            generatePillars()
        }
    }

    func generatePillars() {
        let gap = CGFloat.random(in: GameViewModel.minGapSize...GameViewModel.maxGapSize)
        
        let topPillarMinHeight = Bird.size.height
        let topPillarMaxHeight = 1 - (Bird.size.height + gap)
        let topPillarHeight = CGFloat.random(in: topPillarMinHeight...topPillarMaxHeight)
        
        let bottomPillarHeight = 1 - (topPillarHeight + gap)

        let pillar = Pillar(xPosition: 1, topHeight: topPillarHeight, bottomHeight: bottomPillarHeight)
        model.pillars.append(pillar)
    }

    func birdJump() {
        if model.isGameOver { return }

        birdVelocity = GameViewModel.jumpPower
        playSound(of: .jump)
    }

    func checkCollisions() {
        if model.bird.position.y >= 1 - Bird.size.height || model.bird.position.y <= 0 {
            endGame()
            return
        }

        for i in 0..<model.pillars.count {
            let pillar = model.pillars[i]
            
            let birdFrame = CGRect(x: model.bird.position.x,
                                   y: model.bird.position.y,
                                   width: Bird.size.width,
                                   height: Bird.size.height)
            
            let topPillarFrame = CGRect(x: pillar.xPosition,
                                        y: 1 - pillar.topHeight,
                                        width: Pillar.width,
                                        height: pillar.topHeight)
            
            let bottomPillarFrame = CGRect(x: pillar.xPosition,
                                           y: 0,
                                           width: Pillar.width,
                                           height: pillar.bottomHeight)
            
            if birdFrame.intersects(topPillarFrame) || birdFrame.intersects(bottomPillarFrame) {
                endGame()
                return
            } else if pillar.xPosition < model.bird.position.x {
                guard !pillar.didPassBird else { continue }
                
                model.score += 1
                model.pillars[i].didPassBird = true
            }
        }
    }
    
    func endGame() {
        model.isGameOver = true
        didStartGame = false
        
        playSound(of: .hit)

        withAnimation(.easeIn(duration: 1.0)) {
            model.bird.rotation = .degrees(90)
            model.bird.position.y = 0
        }

        timer?.invalidate()
        saveScore()
    }

    func playSound(of type: SoundType) {
        if let sound = Bundle.main.url(forResource: SoundType.soundName(of: type), withExtension: "wav") {
            audioPlayer = try? AVAudioPlayer(contentsOf: sound)
            audioPlayer?.play()
        }
    }
        
    private func saveScore() {
        let currentHighScore = UserDefaults.standard.integer(forKey: DataStore.kHighScore)
        
        if model.score > currentHighScore {
            UserDefaults.standard.set(model.score, forKey: DataStore.kHighScore)
        }
    }
}
