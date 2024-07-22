//
//  ForgetpassCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ForgetpassCoordinator: Coordinator {
    typealias PresentingView = ForgetpassVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ForgetpassCoordinator {
    func verify() {
        guard let scene = R.storyboard.verifyCodeStoryboard.verifyCodeVC() else { return }
        scene.mobile = view?.phoneTxf.text ?? ""
        scene.code = "+966"
        scene.time = view?.viewModel?.resenddata.value?.data?.timer ?? 0
        scene.type = .forget
        view?.push(scene)
    }
}
