//
//  EditPhoneCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class EditPhoneCoordinator: Coordinator, VerifycodeVCCDelegate {
    
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
        scene.isorder = view?.isorder ?? 0
        if view?.isorder ?? 0 == 1 {
            scene.delegate = self
        }
        view?.push(scene)

    }
    func done() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
