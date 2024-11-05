//
//  Navigator.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine

/* NOTES:
 - shared is a singleton Navigator object; this makes it to only one object is used throughout the entire app to keep navigation simple; it's all in one place
 - path works like a page history in a web browser; it keeps track of what screen you are currently on and the past screens
 - the last element in path is the current screen; if it is empty that means the user is in the home screen
 - navigate handles the navigation
 */

class Navigator: ObservableObject {
    static let shared = Navigator()
    
    @Published var path = [ViewID]()
    
    func navigate(to viewID: ViewID) {
        if let existingViewIndex = path.firstIndex(of: viewID) {
            // if the requested view is already in the history, just go to the existing view in the history; kind of like how you would press the back arrow in a web browser
            let lastIndex = path.count - 1
            path.removeLast(lastIndex - existingViewIndex)
        } else if viewID == .home {
            // if the user requests to go to the home screen remove everything from the path since an empty path represents the home screen
            path.removeAll(keepingCapacity: true)
        } else {
            // if the requested view isn't already in the history, just add it to the path
            path.append(viewID)
        }
    }
}
