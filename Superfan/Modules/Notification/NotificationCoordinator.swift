//
//  NotificationCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class NotificationCoordinator: Coordinator {
    typealias PresentingView = NotificationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NotificationCoordinator {
    func notdetails(id: Int?) {
        guard let scene = R.storyboard.newsDetailsStoryboard.newsDetailsVC() else { return }
        scene.newsId = id ?? 0
        view?.push(scene)
    }
    func comments(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
    func reply(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        scene.type = .reply
        view?.push(scene)
    }
    func detailsbackstages(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        scene.isbackstage = true
        view?.push(scene)
    }
   
    func detailsposts(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
}
