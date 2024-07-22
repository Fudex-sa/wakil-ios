//
//  SignupCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SignupCoordinator: Coordinator, SelectLocVCDelegate {
    typealias PresentingView = SignupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SignupCoordinator {
    func verify(){
        guard let scene = R.storyboard.verifyCodeStoryboard.verifyCodeVC() else { return }
        scene.time = view?.viewModel?.userdata.value?.data?.user?.timer ?? 0
        view?.push(scene)
    }
    func terms() {
        guard let scene = R.storyboard.termsStoryboard.termsVC() else { return }
        view?.push(scene)
    }
    func locate(){
        guard let scene = R.storyboard.selectLocStoryboard.selectLocVC() else { return }
        scene.lat = view?.viewModel?.lat.value?.double() ?? 0
        scene.lng = view?.viewModel?.lng.value?.double() ?? 0
        scene.delegate = self
        view?.pushPop(scene)
    }
    func locate(lat: Double, lng: Double, loc: String) {
        view?.viewModel?.lat.send(lat.string)
        view?.viewModel?.lng.send(lng.string)
        view?.mapLbl.text = loc
        view?.viewModel?.location.send(loc)
        if loc != "Locate on map".localized {
            view?.mapLbl.textColor = R.color.black()
        }else {
            view?.mapLbl.textColor = R.color.black1()

        }
    }
}
