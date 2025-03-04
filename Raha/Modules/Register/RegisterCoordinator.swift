//
//  RegisterCoordinator.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class RegisterCoordinator: Coordinator {
    typealias PresentingView = RegisterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension RegisterCoordinator {
    func verify(){
        guard let scene = R.storyboard.verifycodeStoryboard.verifycodeVC() else { return }
      //  scene.time = view?.viewModel?.userdata.value?.data?.user?.timer ?? 0
        view?.push(scene)
    }
    func terms() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        view?.push(scene)
    }
}
