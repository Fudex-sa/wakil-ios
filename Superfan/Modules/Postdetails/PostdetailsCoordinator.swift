//
//  PostdetailsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class PostdetailsCoordinator: Coordinator {
    typealias PresentingView = PostdetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension PostdetailsCoordinator {
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
        view?.push(scene)
    }
}
