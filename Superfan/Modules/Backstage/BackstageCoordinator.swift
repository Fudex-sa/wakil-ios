//
//  BackstageCoordinator.swift
//  Superfan
//
//  Created by ADAM on 12/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class BackstageCoordinator: Coordinator {
    typealias PresentingView = BackstageVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension BackstageCoordinator {
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
        view?.push(scene)
    }
    func detailsposts(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        scene.isbackstage = true
        view?.push(scene)
    }
    func addpost() {
        guard let scene = R.storyboard.addPostStoryboard.addPostVC() else { return }
        view?.push(scene)
    }
    func comments(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        scene.isbackstage = true
        view?.push(scene)
    }
}
