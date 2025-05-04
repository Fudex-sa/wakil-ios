//
//  HomeCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class HomeCoordinator: Coordinator, SelectAddressVCDelegate, FilterServiceVCDelegate, ChooseLocMethodVCDelegate {
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
        scene.loctype = view?.viewModel?.loctype.value ?? ""
        view?.push(scene)
    }
    func done(model:AddressesDatum){
        view?.locLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        view?.addressdata = model
        view?.viewModel?.lat.send(model.lat?.double() ?? 0.0)
        view?.viewModel?.lng.send(model.lng?.double() ?? 0.0)
        view?.viewModel?.resetPaginator()
        view?.viewModel?.clearDataSource()
        view?.viewModel?.fetchhome()
    }
    func done(model: FilterServiceModel) {
        view!.filter = model
        view?.viewModel?.distance.send(model.distance ?? "")
        view?.viewModel?.gender.send(model.gender ?? "")
        view?.viewModel?.rate.send(model.rate ?? "")
        view?.viewModel?.loctype.send(model.loctype ?? "")
        view?.viewModel?.servicetype.send(model.servicetype ?? "")
        view?.viewModel?.resetPaginator()
        view?.viewModel?.clearDataSource()
        view?.viewModel?.fetchhome()
    }
    func currentloc() {
        guard let scene = R.storyboard.chooseLocMethodStoryboard.chooseLocMethodVC() else { return }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func notification() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        guard let scene = R.storyboard.notificationStoryboard.notificationVC() else { return }
        view?.push(scene)
    }
    func detailsreservation(id:Int) {
        guard let scene = R.storyboard.detailsreservationStoryboard.detailsreservationVC() else { return }
        scene.orderId = id
        view?.push(scene)
    }
    func complains(){
        guard let scene = R.storyboard.complainsStoryboard.complainsVC() else { return }
        view?.push(scene)
    }
    func addaddressreturn() {
        guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
        scene.isfirst = true
        view?.push(scene)
    }
    
    func currentlocreturn() {
        view?.currentlocation()
    }
    func close() {
        UD.lat = 0.0
        UD.lng = 0.0
        view?.viewModel?.fetchhome()
    }
    
}
