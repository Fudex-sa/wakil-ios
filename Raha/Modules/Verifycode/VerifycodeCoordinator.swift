//
//  VerifycodeCoordinator.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class VerifycodeCoordinator: Coordinator {
    typealias PresentingView = VerifycodeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension VerifycodeCoordinator {
    func resetpass() {
        guard let scene = R.storyboard.resetpasswordStoryboard.resetpasswordVC() else { return }
        let code = view?.verifyCodeInputs?.code?.cut(charSplit: "-", charWith: "")
        scene.otp = code ?? ""
        scene.mobile = view?.mobile ?? ""
       // scene.code = view?.code ?? ""
        view?.push(scene)
    }
}
