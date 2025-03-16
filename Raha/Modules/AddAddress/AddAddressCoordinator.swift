//
//  AddAddressCoordinator.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class AddAddressCoordinator: Coordinator, SelectonmapVCDelegate {
    typealias PresentingView = AddAddressVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AddAddressCoordinator {
        func locate(){
            guard let scene = R.storyboard.selectonmapStoryboard.selectonmapVC() else { return }
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
            view?.locLbl.text = loc
            view?.locLbl.textColor = R.color.black1()
        }
}
