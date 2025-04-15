//
//  ProfileCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
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
        guard let scene = R.storyboard.editProfileStoryboard.editProfileVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editemail() {
        guard let scene = R.storyboard.editEmailStoryboard.editEmailVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editphone() {
        guard let scene = R.storyboard.editPhoneStoryboard.editPhoneVC() else { return }
        scene.user = view?.viewModel?.userddata.value
        view?.push(scene)
    }
    func editpassword() {
        guard let scene = R.storyboard.editPasswordStoryboard.editPasswordVC() else { return }
        view?.push(scene)
    }
    func addresses() {
        guard let scene = R.storyboard.addressStoryboard.addressVC() else { return }
        view?.push(scene)
    }
    func deleteaccount() {
        guard let scene = R.storyboard.logoutStoryboard.logoutVC() else { return }
        scene.type = .account
        view?.pushPop(scene)
    }
}
