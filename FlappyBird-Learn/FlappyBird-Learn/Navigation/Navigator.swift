//
//  Navigator.swift
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

import Combine

class Navigator: ObservableObject {
    static let shared = Navigator()
    
    @Published var path = [ViewID]()
    
    func navigate(to viewID: ViewID) {
        if let existingViewIndex = path.firstIndex(of: viewID) {
            let lastIndex = path.count - 1
            path.removeLast(lastIndex - existingViewIndex)
        } else if viewID == .home {
            path.removeAll(keepingCapacity: true)
        } else {
            path.append(viewID)
        }
    }
}
