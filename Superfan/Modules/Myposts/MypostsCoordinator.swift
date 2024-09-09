//
//  MypostsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class MypostsCoordinator: Coordinator {
    typealias PresentingView = MypostsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MypostsCoordinator {
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
        view?.push(scene)
    }
    func detailsposts(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
    func addpost() {
        guard let scene = R.storyboard.addPostStoryboard.addPostVC() else { return }
        view?.push(scene)
    }
}
