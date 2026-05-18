//
//  VerifyCoordinator.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class VerifyCoordinator: Coordinator {
    typealias PresentingView = VerifyVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension VerifyCoordinator {
    func resetpass() {
            guard let scene = R.storyboard.resetpassStoryboard.resetpassVC() else { return }
            let code = view?.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
            scene.otp = code ?? ""
            scene.mobile = view?.mobile ?? ""
           // scene.code = view?.code ?? ""
            view?.push(scene)
        }
}
