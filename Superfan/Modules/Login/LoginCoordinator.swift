//
//  LoginCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class LoginCoordinator: Coordinator {
    typealias PresentingView = LoginVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension LoginCoordinator {
    func forgetpass(){
        guard let scene = R.storyboard.forgetpassStoryboard.forgetpassVC() else { return }
        view?.push(scene)
    }
    
    func register(){
        guard let scene = R.storyboard.signupStoryboard.signupVC() else { return }
        view?.push(scene)
    }
    func registersocail(){
        guard let scene = R.storyboard.signupStoryboard.signupVC() else { return }
        scene.email = view?.viewModel?.email.value ?? ""
        scene.socailId = view?.viewModel?.socailId.value ?? ""
        scene.type = view?.viewModel?.socialType.value ?? 0
        scene.name = view?.viewModel?.name.value ?? ""
        view?.push(scene)
    }
    func verify(){
        guard let scene = R.storyboard.verifyCodeStoryboard.verifyCodeVC() else { return }
        view?.push(scene)
    }
}
