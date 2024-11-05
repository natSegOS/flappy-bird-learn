//
//  SoundType.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import AVFoundation

/* NOTES:
 - control the general behavior of the sounds you will be using in the game; customize as needed
 */

enum SoundType {
    // TODO: list all the types of sounds you will be using in the game
    case backgroundMusic
    case jump
    case hit
    
    // TODO: define the file name (everything before the file extension) for a given sound
    static func fileName(of type: SoundType) -> String {
        switch type {
        case .jump:
            return "jump"
            
        case .hit:
            return "Death"
            
        case .backgroundMusic:
            return "duckSong"
        }
    }
    
    // TODO: define the file type of a given sound
    static func fileType(of type: SoundType) -> String {
        switch type {
        case .jump:
            return "wav"
            
        case .hit:
            return "wav"
            
        case .backgroundMusic:
            return "wav"
        }
    }
    
    // TODO: define how many times a given sound type should be played
    static func loopNumber(of type: SoundType) -> Int {
        switch type {
        case .jump:
            return 1
            
        case .hit:
            return 1
            
        case .backgroundMusic:
            return -1 // -1 represents infinity, meaning loop forever (or until stopped)
        }
    }
    
    // it's only necessary to keep a reference to the AVAudioPlayer if you will continue to use it after playing the sound, so it's okay to just not use it and discard it; hence the @discardableResult decorator
    @discardableResult
    static func playSound(of type: SoundType) -> AVAudioPlayer? {
        if let sound = Bundle.main.url(forResource: SoundType.fileName(of: type), withExtension: SoundType.fileType(of: type)) {
            let audioPlayer = try? AVAudioPlayer(contentsOf: sound)
            audioPlayer?.volume = Preferences.shared.volume
            audioPlayer?.numberOfLoops = SoundType.loopNumber(of: type)
            audioPlayer?.play()
            
            return audioPlayer
        }
        
        return nil
    }
}
