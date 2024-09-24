//
//  CommentsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class CommentsCoordinator: Coordinator, deleteAccountPopupVCDelegate {

    typealias PresentingView = CommentsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CommentsCoordinator {
    func comments(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        scene.type = .reply
        view?.push(scene)
    }
    func deletecomment(type1:Int) {
        guard let scene = R.storyboard.deleteaccountpopupStoryboard.deleteaccountpopupVC() else { return }
        if type1 == 0 {
            scene.viewType = .comment
        }else {
            scene.viewType = .reply
        }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.startLoading()
        view?.viewModel?.deletecomments()
    }
}
