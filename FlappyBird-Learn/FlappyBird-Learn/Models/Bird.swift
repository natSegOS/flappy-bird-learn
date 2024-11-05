//
//  Bird.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

/* NOTES:
 - represent a bird via its position and the angle it is rotated
 */

struct Bird {
    static let size = CGSize(width: 0.1, height: 0.1 * UIScreen.size.width / UIScreen.size.height) // 10% of screen width
    
    var position: CGPoint
    var rotation: Angle
    
    // transform the bird from CoreGraphics coordinates to SwiftUI coordinates
    // these coordinate systems are explained in the Pillar.swift and Render.swift files
    
    // in the code comments i put the math equations i used to transform between coordinate systems
    var render: Render {
        let screenSize = UIScreen.size
        
        // x_r = (x + w/2)*S_w
        // • x_r is the x-coordinate in SwiftUI coordinates
        // • x is the x-coordinate in CoreGraphics coordinates
        // • w is the width of the graphic in CoreGraphics coordinates
        // • S_w is the width of the screen in SwiftUI coordinates
        
        // y_r = (1 - y + h/2)*S_h
        // • y_r is the y-coordinate in SwiftUI coordinates
        // • y is the y-coordinate in CoreGraphics coordinates
        // • h is the height of the graphic in CoreGraphics coordinates
        // • S_h is the height of the screen in SwiftUI coordinates
        
        return Render(x: (position.x + Bird.size.width / 2) * screenSize.width,
                      y: (1 - position.y - Bird.size.height / 2) * screenSize.height,
                      width: Bird.size.width * screenSize.width,
                      height: Bird.size.height * screenSize.height,
                      zIndex: 0,
                      category: .player)
    }
}
