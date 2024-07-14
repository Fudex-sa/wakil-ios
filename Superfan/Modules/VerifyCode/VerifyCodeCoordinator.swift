//
//  VerifyCodeCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class VerifyCodeCoordinator: Coordinator {
    typealias PresentingView = VerifyCodeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension VerifyCodeCoordinator {
    func resetpass() {
        guard let scene = R.storyboard.resetpasswordStoryboard.resetpasswordVC() else { return }
        let code = view?.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
//        scene.otp = code ?? ""
//        scene.mobile = view?.mobile ?? ""
//        scene.code = view?.code ?? ""
        view?.push(scene)
    }
}
