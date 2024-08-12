//
//  SoundType.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/11/24.
//

import Foundation

enum SoundType {
    case jump
    case hit
    
    static func soundName(of type: SoundType) -> String {
        switch type {
        case .jump:
            return "" // TODO: name of jump sound file
            
        case .hit:
            return "" // TODO: name of death sound file
        }
    }
}
