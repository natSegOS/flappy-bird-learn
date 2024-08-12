//
//  Pillar.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

struct Pillar: Hashable {
    static let width: CGFloat = 0.1 // 10% of screen width
    
    var xPosition: CGFloat
    var topHeight: CGFloat
    var bottomHeight: CGFloat
    
    var didPassBird = false
    
    var topRender: CGRect {
        let screenSize = UIScreen.size
        
        return CGRect(x: (xPosition + Pillar.width / 2) * screenSize.width,
                      y: topHeight * screenSize.height / 2,
                      width: Pillar.width * screenSize.width,
                      height: topHeight * screenSize.height)
    }
    
    var bottomRender: CGRect {
        let screenSize = UIScreen.size
        
        return CGRect(x: (xPosition + Pillar.width / 2) * screenSize.width,
                      y: (1 - bottomHeight / 2) * screenSize.height,
                      width: Pillar.width * screenSize.width,
                      height: bottomHeight * screenSize.height)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(xPosition)
    }
}
