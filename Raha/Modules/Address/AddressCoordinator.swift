//
//  AddressCoordinator.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class AddressCoordinator: Coordinator , LogoutVCDelegate {
    typealias PresentingView = AddressVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AddressCoordinator {
    func addaddress() {
        guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
        view?.push(scene)
    }
    func editaddress() {
        guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
        view?.push(scene)
    }
    func delete() {
        guard let scene = R.storyboard.logoutStoryboard.logoutVC() else { return }
        scene.type = .address
        scene.delegate = self
        view?.pushPop(scene)
    }
    func address() {
        view?.stopLoading()
        view?.viewModel?.deleteaddress()
    }
}
