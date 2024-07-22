//
//  EditprofileCoordinator.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class EditprofileCoordinator: Coordinator, SelectLocVCDelegate {
   
    
    typealias PresentingView = EditprofileVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension EditprofileCoordinator {
    func locate(){
        guard let scene = R.storyboard.selectLocStoryboard.selectLocVC() else { return }
        if view?.viewModel?.lat.value?.double() ?? 0 != 0 {
            scene.lat1 = view?.viewModel?.lat.value?.double() ?? 0
            scene.lng1 = view?.viewModel?.lng.value?.double() ?? 0
        }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func locate(lat: Double, lng: Double, loc: String) {
        view?.viewModel?.lat.send(lat.string)
        view?.viewModel?.lng.send(lng.string)
        view?.mapLbl.text = loc
    }
}
