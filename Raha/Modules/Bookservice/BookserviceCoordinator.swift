//
//  BookserviceCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class BookserviceCoordinator: Coordinator, SelectAddressVCDelegate {
    
    
    typealias PresentingView = BookserviceVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension BookserviceCoordinator {
    func selectaddress() {
        guard let scene = R.storyboard.selectAddressStoryboard.selectAddressVC() else { return }
        scene.addressId = view?.address?.id ?? 0
        scene.book = true
        scene.delegate = self
        view?.pushPop(scene)
    }
    func addaddress() {
        guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
        view?.pushPop(scene)
    }
    func done(model: AddressesDatum) {
        view?.address = model
        view?.addressLbl.text = "\(model.street ?? "") - \(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
    }
    func paymentdone() {
        guard let scene = R.storyboard.paymentDoneStoryboard.paymentDoneVC() else { return }
        view?.pushPop(scene)
    }
}
