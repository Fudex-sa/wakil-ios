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
        guard let scene = R.storyboard.forgetStoryboard.forgetVC() else { return }
        view?.push(scene)
   }
    
    func register(){
        if UD.type == 1 {
            guard let scene = R.storyboard.registeruserStoryboard.registeruserVC() else { return }
            view?.push(scene)
        }else if UD.type == 2 {
            guard let scene = R.storyboard.providerregisterStoryboard.providerregisterVC() else { return }
            view?.push(scene)
        }
    }
    func registersocail(){
//        guard let scene = R.storyboard.registerStoryboard.registerVC() else { return }
//        scene.email = view?.viewModel?.email.value ?? ""
//        scene.socailId = view?.viewModel?.socailId.value ?? ""
//        scene.type = view?.viewModel?.socialType.value ?? 0
//        scene.name = view?.viewModel?.name.value ?? ""
//        view?.push(scene)
    }
    func verify(){
//        guard let scene = R.storyboard.verifycodeStoryboard.verifycodeVC() else { return }
//       // scene.time = view?.viewModel?.userdata.value?.data?.user?.timer ?? 0
//        view?.push(scene)
    }
}
