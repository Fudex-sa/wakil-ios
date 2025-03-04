//
//  ForgetpasswordCoordinator.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ForgetpasswordCoordinator: Coordinator {
    typealias PresentingView = ForgetpasswordVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ForgetpasswordCoordinator {
    func verify() {
        guard let scene = R.storyboard.verifycodeStoryboard.verifycodeVC() else { return }
        scene.mobile = view?.phoneTxf.text ?? ""
        scene.code = "+966"
        //scene.time = view?.viewModel?.resenddata.value?.data?.timer ?? 0
        scene.type = .forget
        view?.push(scene)
    }
}
