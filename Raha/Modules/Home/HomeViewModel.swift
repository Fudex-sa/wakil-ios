//
//  HomeViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class HomeViewModel: BaseViewModel ,DataSourceViewModel {
    var lat: Publisher<Double> = .init()
    var lng: Publisher<Double> = .init()
    var distance: Publisher<String> = .init()
    var servicetype: Publisher<String> = .init()
    var loctype: Publisher<String> = .init()
    var gender: Publisher<String> = .init()
    var rate: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var addressList: Publisher<[AddressesDatum]> = .init()
    var userddata: Publisher<ProfileModel> = .init()
    var items: Publisher<[HomeDatum]> = .init()
    var addressstatus: Publisher<Bool> = .init()
    var sliders: Publisher<[SlidersDatum]> = .init()
    var slidersFinished: Publisher<Bool> = .init()
}
// MARK: - ...  ViewModel Contract
extension HomeViewModel {
}
// MARK: - ...  Example of network response
extension HomeViewModel {
    func fetchaddresses() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.addresses.rawValue, type: .get, AddressesModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addressList.send(model.data ?? [])
            self?.addressstatus.send(true)
        }).store(self)
    }
    func getprofile() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.profile.rawValue, type: .get, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.userddata.send(model)
        }).store(self)
    }
    func fetchhome() {
        if lat.value ?? 0.0 != 0.0 {
            NetworkManager.instance.paramaters["lat"] = lat.value ?? 0.0
            NetworkManager.instance.paramaters["lng"] = lng.value ?? 0.0
        }
        if distance.value ?? "" != "" {
            NetworkManager.instance.paramaters["max_distance"] = distance.value ?? ""
        }
        if servicetype.value ?? "" != "" {
            NetworkManager.instance.paramaters["service_type"] = servicetype.value ?? ""
        }
        if loctype.value ?? "" != "" {
            NetworkManager.instance.paramaters["location_type"] = loctype.value ?? ""
        }
        if gender.value ?? "" != "" {
            NetworkManager.instance.paramaters["employee_gender"] = gender.value ?? ""
        }
        if rate.value ?? "" != "" {
            NetworkManager.instance.paramaters["rate"] = rate.value ?? ""
        }
        if name.value ?? "" != "" {
            NetworkManager.instance.paramaters["name"] = name.value ?? ""
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.home.rawValue, type: .get, HomeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func fetchsliders() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.sliders.rawValue, type: .get, SlidersModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.sliders.send(model.data ?? [])
            self?.slidersFinished.send(true)
        }).store(self)
    }
}
