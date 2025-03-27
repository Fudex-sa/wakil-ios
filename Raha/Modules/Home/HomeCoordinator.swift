//
//  HomeCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class HomeCoordinator: Coordinator, SelectAddressVCDelegate, FilterServiceVCDelegate {
    
    
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
    func filter() {
        guard let scene = R.storyboard.filterServiceStoryboard.filterServiceVC() else { return }
        scene.filter = view!.filter
        scene.delegate = self
        view?.pushPop(scene)
    }
    func detailscenter(id:Int) {
        guard let scene = R.storyboard.detailscentersStoryboard.detailscentersVC() else { return }
        scene.lat = view?.viewModel?.lat.value ?? 0.0
        scene.lng = view?.viewModel?.lng.value ?? 0.0
        scene.centerId = id
        view?.push(scene)
    }
    func done(model:AddressesDatum){
        view?.locLbl.text = "\(model.street ?? "") - \(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        view?.addressdata = model
        view?.viewModel?.lat.send(model.lat?.double() ?? 0.0)
        view?.viewModel?.lng.send(model.lng?.double() ?? 0.0)
        view?.viewModel?.homedata.send([])
        view?.viewModel?.fetchhome()
    }
    func done(model: FilterServiceModel) {
        view!.filter = model
        view?.viewModel?.distance.send(model.distance ?? "")
        view?.viewModel?.gender.send(model.gender ?? "")
        view?.viewModel?.rate.send(model.rate ?? "")
        view?.viewModel?.loctype.send(model.loctype ?? "")
        view?.viewModel?.servicetype.send(model.servicetype ?? "")
        view?.viewModel?.homedata.send([])
        view?.viewModel?.fetchhome()
    }
}
