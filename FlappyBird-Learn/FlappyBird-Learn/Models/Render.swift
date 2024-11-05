//
//  Render.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 10/12/24.
//

/* NOTES:
 - represents a render on the screen
 - renders have coordinates (x, y); this is based on where the center of the graphic is
 - the origin (0, 0) of the coordinate-system of the screen is at the top-left of the screen
 - the further down the screen, the higher the y-coordinate; the y-coordinate of the bottom of the screen is just the height of the screen in pixels
 - the futher to the right of the screen, the higher the x-coordinate; the x-coordinate of the far right of the screen is just the width of the screen in pixels
 
 - zIndex lets you control what renders are on top of each other
 - the render with the highest zIndex would be on top of any other renders if they were to be placed overlapping each other
 - the render with the lowest zIndex would be below any other renders if they were to be placed overlapping each other
 - if any two renders have the same zIndex, the one that was drawn to the screen last will be placed on top if they are overlapping
 
 - category is used to uniquely identify any two renders along with zIndex
 - it is necessary to be able to distinguish one render from another in order to loop over them using SwiftUI's ForEach closure
 
 - DISCLAIMER: The coordinate system used by SwiftUI (the front-end API that i use to show stuff to the user) is different from the coordinate system used by CoreGraphics (the internal API that i use to do computations) which is why i use coordinate transformations when creating renders in the Pillar and Bird models
 */

struct Render: Hashable {
    let x: Double
    let y: Double
    
    let width: Double
    let height: Double
    
    let zIndex: Double
    let category: RenderType
    
    init(x: Double = 0, y: Double = 0, width: Double, height: Double, zIndex: Double = 0, category: RenderType = .none) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.zIndex = zIndex
        self.category = category
    }
    
    // if the render was a top pillar with a zIndex of 100, its ID that is sent to the hasher would be: t100
    // if it was a player with a zIndex of 100, its ID would be: p100
    // if it was a bottom pillar with a zIndex of 223, its ID would be: b223
    // as you can see, its possible multiple renders have the same zIndex which is why it is necessary for them to be distinguished further; i chose to do this via a category because in the system i set up, only one render in a given category will have a particular zIndex
    // look into hashing if you are unfamiliar with the concept; it is used for unique identification
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(RenderType.code(for: category))\(zIndex)")
    }
}

enum RenderType {
    case player
    case topPillar
    case bottomPillar
    case none
    
    static func code(for type: RenderType) -> String {
        switch type {
        case .player:
            return "p"
        case .topPillar:
            return "t"
        case .bottomPillar:
            return "b"
        default:
            return ""
        }
    }
}
