//
//  ForgetCoordinator.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ForgetCoordinator: Coordinator {
    typealias PresentingView = ForgetVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ForgetCoordinator {
    func verify() {
            guard let scene = R.storyboard.verifyStoryboard.verifyVC() else { return }
            scene.mobile = view?.phoneTxf.text ?? ""
            scene.code = "+966"
            //scene.time = view?.viewModel?.resenddata.value?.data?.timer ?? 0
            scene.type = .forget
            view?.push(scene)
        }
}
