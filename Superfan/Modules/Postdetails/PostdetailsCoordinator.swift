//
//  PostdetailsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class PostdetailsCoordinator: Coordinator, deleteAccountPopupVCDelegate {
    
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
    func editpost() {
        guard let scene = R.storyboard.addPostStoryboard.addPostVC() else { return }
        scene.postdata = view?.viewModel?.postdata.value
        scene.type = .edit
        view?.push(scene)
    }
    func deletepost() {
        guard let scene = R.storyboard.deleteaccountpopupStoryboard.deleteaccountpopupVC() else { return }
        scene.viewType = .post
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.startLoading()
        view?.viewModel?.deletepost()
    }
    
   
}
