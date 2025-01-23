//
//  PostsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 22/01/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class PostsCoordinator: Coordinator {
    typealias PresentingView = PostsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension PostsCoordinator {
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
    func comments(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
}
