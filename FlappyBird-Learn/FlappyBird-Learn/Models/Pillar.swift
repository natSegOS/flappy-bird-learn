//
//  Pillar.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import SwiftUI

// this is just a list of to-dos; they may not be relevant to this particular file. just general goals
// TODO: break pillar into finite parts, make each part overlap each other, have a lip at the end
// TODO: make bird bounce when hitting side of pillar
// TODO: make bird roll off pillar when hitting top of pillar
// TODO: go to end screen after death animation
// TODO: speed up over time
// TODO: tilt forward when falling, tilt backward when jumping

/* NOTES:
 - in CoreGraphics, the coordinates of a graphic is represented by where the bottom-left corner of that graphic is
 - the origin (0, 0) of the coordinate sytems in CoreGraphics is the bottom-left corner of the screen
 - using UV-coordinates, meaning the x-coordinate ranges from 0 to 1 and the y-coordinate also ranges from 0 to 1. They represent percentages of along the screen. So, if the object were 10% across the screen's width, its x-coordinate would be 0.1. Same idea for the y-coordinate. And if it were at the end of the screen's width (i.e., 100% of the screen), its x-coordinate would be 1. Same idea for y-coordinate.
 - the higher up the screen, the higher the y-coordinate; the y-coordinate of the top of the screen is simply 1
 - the farther to the right, the higher the x-coordinate; the x-coordinate of the far right of the screen is simply 1
 */

struct Pillar: Hashable {
    static let width: CGFloat = 0.1 // width of a given pillar is 10% of screen width
    
    // Aspect Ratios
    static let topPillarPieceAspectRatio = 1.0 // TODO: aspect ratio of the image you are using for a top pillar piece
    static let bottomPillarPieceAspectRatio = 1.0 // TODO: aspect ratio of the image you are using for a bottom pillar piece
    
    static let topPillarLipAspectRatio = 1.0 // TODO: aspect ratio of the image you are using for a top pillar lip
    static let bottomPillarLipAspectRatio = 1.0 // TODO: aspect ratio of the image you are using for a bottom pillar lip
    
    // Heights
    static let topPillarPieceHeight = Pillar.width * topPillarPieceAspectRatio
    static let bottomPillarPieceHeight = Pillar.width * bottomPillarPieceAspectRatio
    
    static let topPillarPieceEndHeight = 0.05 // percent of end height compared to entire pillar image height (including the end)
    static let bottomPillarPieceEndHeight = 0.01 // ditto ^
    
    static let topPillarLipHeight = 2 * topPillarPieceEndHeight
    static let bottomPillarLipHeight = 2 * bottomPillarPieceEndHeight
    
    static let topPillarLipWidth = topPillarLipHeight / topPillarLipAspectRatio
    static let bottomPillarLipWidth = bottomPillarLipHeight / bottomPillarLipAspectRatio
    
    var xPosition: CGFloat // x-coordinate of a pillar; this uniquely distinguishes a pillar because pillars are never in same place
    let topHeight: Int // number of top pillar pieces
    let bottomHeight: Int // number of bottom pillar pieces
    
    let totalTopHeight: CGFloat // topHeight transformed into pixel measurement
    let totalBottomHeight: CGFloat // bottomHeight transformed into pixel measurement
    
    var didPassBird = false // represents whether a particular pillar has passed the bird which is helpful in keeping track of how many pillars the bird has survived. it also prevents counting the same pillar multiple times since this code is run many times per second; it represents a flag of whether you have already accounted for this particular pillar
    
    init(xPosition: CGFloat, topHeight: Int, bottomHeight: Int) {
        self.xPosition = xPosition
        self.topHeight = topHeight
        self.bottomHeight = bottomHeight
        
        self.totalTopHeight = Double(topHeight) * Pillar.topPillarPieceHeight
        self.totalBottomHeight = Double(bottomHeight) * Pillar.bottomPillarPieceHeight
    }
    
    // **NOTE**: DO NOT DELETE EXPLICIT TYPE ANNOTATIONS HERE; COMPUTATION IS TOO COMPLEX FOR SWIFT TO PROCESS OTHERWISE
    // this code converts from CoreGraphics coordinates to SwiftUI coordinates. The SwiftUI coordinate system is explained in the Render.swift file
    // using the transformed coordinate system, this code creates a Render object for the pieces of the top part of the pillar and the top lip
    
    // in the code comments i put the math equations i used to transform between coordinate systems
    var topRenders: (pieces: [Render], lip: Render) {
        let screenSize: CGSize = UIScreen.size
        
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
        
        let renderXPosition: CGFloat = (xPosition + 0.5 * Pillar.width) * screenSize.width
        let renderYLipPosition: CGFloat = (CGFloat(topHeight) * (Pillar.topPillarPieceHeight - Pillar.topPillarPieceEndHeight) + 0.5 * Pillar.topPillarPieceHeight) * screenSize.height
        
        let renderWidth: CGFloat = Pillar.width * screenSize.width
        let renderLipWidth: CGFloat = Pillar.topPillarLipWidth * screenSize.width
        let renderHeight: CGFloat = Pillar.topPillarPieceHeight * screenSize.height
        let renderLipHeight: CGFloat = Pillar.topPillarLipHeight * screenSize.height
        
        let pieceHeightDifference: CGFloat = Pillar.topPillarPieceHeight - Pillar.topPillarPieceEndHeight
        let halfPieceHeight: CGFloat = 0.5 * Pillar.topPillarPieceHeight
        
        let range: [Int] = Array(0..<topHeight) // create an array that makes it easier to construct the nth piece; the 0th piece should start at the top of the screen, the 1st piece should start at the bottom of the 0th piece, the 2nd piece should start at the bottom of the 1st piece, and so on
        
        let pieces: [Render] = range.map { (index: Int) -> Render in
            // Double is interchangeable with CGFloat
            let yCoord = (Double(index) * pieceHeightDifference + halfPieceHeight) * screenSize.height
            
            return Render(x: renderXPosition,
                   y: yCoord,
                   width: renderWidth,
                   height: renderHeight,
                   zIndex: Double(topHeight - index - 1),
                   category: .topPillar)
        }
        
        let lip = Render(x: renderXPosition,
                         y: renderYLipPosition,
                         width: renderLipWidth,
                         height: renderLipHeight,
                         zIndex: 1,
                         category: .topPillar)
        
        return (pieces: pieces, lip: lip)
    }
    
    // **NOTE**: DO NOT DELETE EXPLICIT TYPE ANNOTATIONS HERE; COMPUTATION IS TOO COMPLEX FOR SWIFT TO PROCESS OTHERWISE
    // this code converts from CoreGraphics coordinates to SwiftUI coordinates. The SwiftUI coordinate system is explained in the Render.swift file
    // using the transformed coordinate system, this code creates a Render object for the pieces of the bottom part of the pillar and the bottom lip
    
    // in the code comments i put the math equations i used to transform between coordinate systems
    var bottomRenders: (pieces: [Render], lip: Render) {
        let screenSize: CGSize = UIScreen.size
        
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
        
        let renderXPosition: CGFloat = (xPosition + 0.5 * Pillar.width) * screenSize.width
        let renderYLipPosition: CGFloat = (1 - CGFloat(topHeight) * (Pillar.bottomPillarPieceHeight - Pillar.bottomPillarPieceEndHeight) - 0.5 * Pillar.bottomPillarPieceHeight) * screenSize.height
        
        let renderWidth: CGFloat = Pillar.width * screenSize.width
        let renderLipWidth: CGFloat = Pillar.bottomPillarLipWidth * screenSize.width
        let renderHeight: CGFloat = Pillar.bottomPillarPieceHeight * screenSize.height
        let renderLipHeight: CGFloat = Pillar.bottomPillarLipHeight * screenSize.height
        
        let pieceHeightDifference: CGFloat = Pillar.bottomPillarPieceHeight - Pillar.bottomPillarPieceEndHeight
        let halfPieceHeight = 0.5 * Pillar.bottomPillarPieceHeight
        
        let range: [Int] = Array(0..<bottomHeight) // create an array that makes it easier to construct the nth piece; the 0th piece should start at the bottom of the screen, the 1st piece should start at the top of the 0th piece, the 2nd piece should start at the top of the 1st piece, and so on
        
        let pieces: [Render] = range.map { (index: Int) -> Render in
            // Double is interchangeable with CGFloat
            let yCoord = (1.0 - Double(index) * pieceHeightDifference - halfPieceHeight) * screenSize.height
            
            return Render(x: renderXPosition,
                   y: yCoord,
                   width: renderWidth,
                   height: renderHeight,
                   zIndex: Double(bottomHeight - index - 1),
                   category: .bottomPillar)
        }
        
        let lip = Render(x: renderXPosition,
                         y: renderYLipPosition,
                         width: renderLipWidth,
                         height: renderLipHeight,
                         zIndex: 1,
                         category: .bottomPillar)
        
        return (pieces: pieces, lip: lip)
    }
    
    func hash(into hasher: inout Hasher) {
        // uniquely distinguish pillars using their x-position;
        // look into hashing if you are unfamiliar with the concept; it is used for unique identification
        hasher.combine(xPosition)
    }
}
