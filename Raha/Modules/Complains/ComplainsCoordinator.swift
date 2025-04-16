//
//  ComplainsCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ComplainsCoordinator: Coordinator {
    typealias PresentingView = ComplainsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ComplainsCoordinator {
    func sendcomplain() {
        guard let scene = R.storyboard.sendcomplainStoryboard.sendcomplainVC() else { return }
        view?.push(scene)
    }
}
