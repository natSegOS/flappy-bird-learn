//
//  GameViewModel.swift
//  FlappyBird
//
//  Created by Nathan on 8/8/24.
//

import AVFoundation
import SwiftUI

/* NOTES:
 - handle the game logic
 - customize as needed
 */

class GameViewModel: ObservableObject {
    static let frameRate = 1.0 / 60.0 // 60 frames per second
    
    static let generatePillarPoint = 0.25 // generate pillars when position is at 25% screen width mark
    static let pillarAcceleration: CGFloat = 0.01 // increase by 1% of screen width per score increment
    static let minGapSize = Bird.size.height * 2 // the minimum gap size for a pillar is 2 birds
    static let maxGapSize = Bird.size.height * 6 // the maximum gap size for a pillar is 6 birds
    
    static let jumpPower = 0.1 // 10% of screen per second
    static let gravity: CGFloat = 0.1 // 10% of screen height per square second
    
    @Published var model: Game // keep track of game state
    
    var pillarSpeed: CGFloat = 0.1 // 10% of screen width per second
    var birdVelocity: CGFloat = 0 // keep track of bird's vertical velocity; negative if falling and positive if jumping
    var didStartGame = false
    
    var timer: Timer? // Timer lets you run code at intervals; this is what lets us update the game state at 60 FPS
    var backgroundMusicAudioPlayer: AVAudioPlayer?
    
    private var lastGameUpdateDate = Date.now // keep track of every update time
    
    init() {
        model = Game()
        backgroundMusicAudioPlayer = SoundType.playSound(of: .backgroundMusic)
    }
    
    deinit {
        backgroundMusicAudioPlayer?.stop()
    }
    
    func startGame() {
        backgroundMusicAudioPlayer?.play(atTime: 0)
        
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

    // this code is run every frame and is responsible for anything you want to happen over the course of the game
    func updateGame(deltaTime: CGFloat) {
        guard didStartGame && !model.isGameOver else { return }

        birdVelocity -= GameViewModel.gravity * deltaTime
        model.bird.position.y += birdVelocity * deltaTime

        model.bird.rotation = .degrees(min(max(-birdVelocity * 2, -90), 90))
        
        for index in model.pillars.indices {
            model.pillars[index].xPosition -= pillarSpeed * deltaTime
        }

        model.pillars.removeAll { $0.xPosition < -Pillar.width }

        checkCollisions()

        if let lastPillar = model.pillars.last, lastPillar.xPosition < GameViewModel.generatePillarPoint {
            generatePillars()
        }
    }

    // code responsible for generating pillars with random characteristics
    func generatePillars() {
        let gap = CGFloat.random(in: GameViewModel.minGapSize...GameViewModel.maxGapSize)
        
        let topPillarMinHeight = Bird.size.height
        let topPillarMaxHeight = 1 - (Bird.size.height + gap)
        let topPillarHeight = CGFloat.random(in: topPillarMinHeight...topPillarMaxHeight)
        
        let bottomPillarHeight = 1 - (topPillarHeight + gap)

        let pillar = Pillar(xPosition: 1,
                            topHeight: Int(floor(topPillarHeight / Pillar.topPillarPieceHeight)),
                            bottomHeight: Int(floor(bottomPillarHeight / Pillar.bottomPillarPieceHeight)))
        
        model.pillars.append(pillar)
    }

    func birdJump() {
        if model.isGameOver { return }

        birdVelocity = GameViewModel.jumpPower
        SoundType.playSound(of: .jump)
    }

    // this function is responsible for collision detection; this code is fine as it operates within the CoreGraphics UV coordinates
    // if anything is off with collisions it's because graphics are not being rendered properly to represent what is going on in the UV coordinate system
    // you can think of this code as the source of truth; it is saying what is actually happening
    // the tricky part in this app is making sure everything is rendered properly to actually reflect this code
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
                                        y: 1 - pillar.totalTopHeight,
                                        width: Pillar.width,
                                        height: pillar.totalTopHeight)
            
            let bottomPillarFrame = CGRect(x: pillar.xPosition,
                                           y: 0,
                                           width: Pillar.width,
                                           height: pillar.totalBottomHeight)
            
            if birdFrame.intersects(topPillarFrame) || birdFrame.intersects(bottomPillarFrame) {
                endGame()
                return
            } else if pillar.xPosition < model.bird.position.x {
                guard !pillar.didPassBird else { continue }
                
                model.score += 1
                model.pillars[i].didPassBird = true
                
                // anytime a pillar is passed, increase pillar speed
                pillarSpeed += GameViewModel.pillarAcceleration
            }
        }
    }
    
    func endGame() {
        model.isGameOver = true
        didStartGame = false
        
        SoundType.playSound(of: .hit)
        backgroundMusicAudioPlayer?.stop()

        // animate bird rotation upon death
        withAnimation(.easeIn(duration: 1.0)) {
            model.bird.rotation = .degrees(90)
            model.bird.position.y = 0
        }

        timer?.invalidate()
        saveScore()
    }
        
    private func saveScore() {
        let currentHighScore = UserDefaults.standard.integer(forKey: DataStore.kHighScore)
        
        if model.score > currentHighScore {
            UserDefaults.standard.set(model.score, forKey: DataStore.kHighScore)
        }
    }
}
