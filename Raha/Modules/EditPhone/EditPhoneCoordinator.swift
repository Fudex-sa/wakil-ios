//
//  EditPhoneCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class EditPhoneCoordinator: Coordinator {
    typealias PresentingView = EditPhoneVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension EditPhoneCoordinator {
    func verify() {
        guard let scene = R.storyboard.verifycodeStoryboard.verifycodeVC() else { return }
        scene.mobile = view?.viewModel?.phone.value ?? ""
        scene.type = .update
        view?.push(scene)
    }
}
