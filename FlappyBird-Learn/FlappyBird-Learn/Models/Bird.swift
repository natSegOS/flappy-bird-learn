//
//  Bird.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct Bird {
    static let size = CGSize(width: 0.1, height: 0.1 * UIScreen.size.width / UIScreen.size.height) // 10% of screen width
    
    var position: CGPoint
    var rotation: Angle
    
    var render: CGRect {
        let screenSize = UIScreen.size
        
        return CGRect(x: (position.x + Bird.size.width / 2) * screenSize.width,
                      y: (1 - position.y - Bird.size.height / 2) * screenSize.height,
                      width: Bird.size.width * screenSize.width,
                      height: Bird.size.height * screenSize.height)
    }
}
