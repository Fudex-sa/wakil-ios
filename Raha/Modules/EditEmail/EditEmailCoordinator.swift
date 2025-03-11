//
//  EditEmailCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class EditEmailCoordinator: Coordinator {
    typealias PresentingView = EditEmailVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension EditEmailCoordinator {
    func verify() {
        guard let scene = R.storyboard.verifycodeStoryboard.verifycodeVC() else { return }
        scene.mobile = view?.viewModel?.email.value ?? ""
        scene.type = .updateemail
        view?.push(scene)
    }
}
