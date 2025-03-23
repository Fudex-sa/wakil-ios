//
//  HomeCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class HomeCoordinator: Coordinator, SelectAddressVCDelegate {
    typealias PresentingView = HomeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension HomeCoordinator {
    func addaddress() {
        guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
        view?.push(scene)
    }
    func selectaddress() {
        guard let scene = R.storyboard.selectAddressStoryboard.selectAddressVC() else { return }
        scene.addressId = view?.addressdata?.id ?? 0
        scene.delegate = self
        view?.pushPop(scene)
    }
    func selectlanguage() {
        guard let scene = R.storyboard.selectLanguageStoryboard.selectLanguageVC() else { return }
        view?.pushPop(scene)
    }
    func done(model:AddressesDatum){
        view?.locLbl.text = "\(model.street ?? "") - \(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        view?.addressdata = model
    }
}
