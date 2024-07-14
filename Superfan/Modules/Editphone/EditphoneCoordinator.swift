//
//  EditphoneCoordinator.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class EditphoneCoordinator: Coordinator {
    typealias PresentingView = EditphoneVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension EditphoneCoordinator {
    func verify() {
        guard let scene = R.storyboard.verifyCodeStoryboard.verifyCodeVC() else { return }
        scene.mobile = view?.viewModel?.phone.value ?? ""
        scene.code = view?.viewModel?.countryCode.value ?? ""
        scene.type = .update
        view?.push(scene)
    }
}
