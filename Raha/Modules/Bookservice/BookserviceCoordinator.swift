//
//  BookserviceCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class BookserviceCoordinator: Coordinator, SelectAddressVCDelegate, GiftVCDelegate, CalenderselectVCDelegate, PaymentmethodVCDelegate {
   
    
    
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
        scene.isfirst = true
        view?.push(scene)
    }
    func done(model: AddressesDatum) {
        view?.address = model
//        view?.addressLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        view?.getAddressFromLatLon(latitude: Double(model.lat ?? "0.0") ?? 0.0, longitude: Double(model.lng ?? "0.0") ?? 0.0) { address in
            if let address = address {
                self.view?.addressLbl.text = address
            } else {
                print("Unable to get address")
            }
        }
        view?.viewModel?.lat.send(Double(model.lat ?? "0.0") ?? 0.0)
        view?.viewModel?.lng.send(Double(model.lng ?? "0.0") ?? 0.0)
        view?.viewModel?.fetchcheckaddress()
    }
    func paymentdone() {
        guard let scene = R.storyboard.paymentDoneStoryboard.paymentDoneVC() else { return }
        view?.pushPop(scene)
    }
    func gift() {
        guard let scene = R.storyboard.giftStoryboard.giftVC() else { return }
        scene.delegate = self
        var gift = GiftModel.init()
        gift.name = view?.viewModel?.name.value ?? ""
        gift.address = view?.viewModel?.address.value ?? ""
        gift.phone = view?.viewModel?.mobile.value ?? ""
        gift.gender = view?.viewModel?.gender.value ?? ""
        gift.lat = view?.viewModel?.latgift.value?.string ?? ""
        gift.lng = view?.viewModel?.lng.value?.string ?? ""
        scene.gift = gift
        view?.pushPop(scene)
    }
    func done(model: GiftModel) {
        view?.viewModel?.name.send(model.name ?? "")
        view?.viewModel?.address.send(model.address ?? "")
        view?.viewModel?.mobile.send(model.phone ?? "")
        view?.viewModel?.gender.send(model.gender ?? "")
        view?.viewModel?.latgift.send(model.lat?.double() ?? 0)
        view?.viewModel?.lnggift.send(model.lng?.double() ?? 0)
        view?.nameLbl.text = model.name ?? ""
        if view?.loctype == "home" {
            view?.viewModel?.fetchcheckaddress()
        }
    }
    func calender() {
        guard let scene = R.storyboard.calenderselectStoryboard.calenderselectVC() else { return }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done(model: Date) {
        view?.calenderView.loadDates(today: model)
    }
    
    func selectpaymentmethod() {
        guard let scene = R.storyboard.paymentmethodStoryboard.paymentmethodVC() else { return }
        scene.paymentmethod = view?.viewModel?.paymentmethodorder.value
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done(model: Int) {
        view?.viewModel?.paymentmethodid.send(model)
        view?.startLoading()
        view?.viewModel?.makecreateorder()
    }
}
