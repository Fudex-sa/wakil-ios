//
//  ProfileCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ProfileCoordinator: Coordinator {
    typealias PresentingView = ProfileVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ProfileCoordinator {
    func editprofile() {
        guard let scene = R.storyboard.editprofileStoryboard.editprofileVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editemail() {
        guard let scene = R.storyboard.editemailStoryboard.editemailVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editphone() {
        guard let scene = R.storyboard.editphoneStoryboard.editphoneVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editpassword() {
        guard let scene = R.storyboard.editpasswordStoryboard.editpasswordVC() else { return }
        view?.push(scene)
    }
    func deleteaccount() {
        guard let scene = R.storyboard.deleteaccountpopupStoryboard.deleteaccountpopupVC() else { return }
        view?.pushPop(scene)
    }
}
