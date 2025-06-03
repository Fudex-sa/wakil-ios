//
//  AddAddressViewModel.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class AddAddressViewModel: BaseViewModel {
    var statesId: Publisher<Int> = .init()
    var street: Publisher<String> = .init()
    var city_id: Publisher<Int> = .init()
    var district: Publisher<String> = .init()
    var lat: Publisher<String> = .init()
    var lng: Publisher<String> = .init()
    var is_default: Publisher<Int> = .init()
    var addressId: Publisher<Int> = .init()
    var states: Publisher<[RegisterModel]> = .init()
    var cities: Publisher<[RegisterModel]> = .init()
    var statesFinished: Publisher<Bool> = .init()
    var citiesFinished: Publisher<Bool> = .init()
    var addressdata: Publisher<AddAddres> = .init()
    var editsdata: Publisher<UserRoot> = .init()

}
// MARK: - ...  ViewModel Contract
extension AddAddressViewModel {
}
// MARK: - ...  Example of network response
extension AddAddressViewModel {
    func fetchstates() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.states.rawValue, type: .get, AddAddressModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.states.send(model.data ?? [])
            self?.statesFinished.send(true)
        }).store(self)
    }
    
    func fetchcities() {
        NetworkManager.instance.paramaters["state_id"] = statesId.value ?? ""
        NetworkManager.instance.request(NetworkConfigration.EndPoint.cities.rawValue, type: .get, AddAddressModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.cities.send(model.data ?? [])
            self?.citiesFinished.send(true)
        }).store(self)
    }
    func addaddress() {
    //    NetworkManager.instance.paramaters["street"] = street.value ?? ""
        if statesId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["state_id"] = statesId.value ?? 0
        }
        if city_id.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["city_id"] = city_id.value ?? 0
        }
        if district.value ?? "" != "" {
            NetworkManager.instance.paramaters["district"] = district.value ?? ""
        }
        NetworkManager.instance.paramaters["lat"] = lat.value ?? ""
        NetworkManager.instance.paramaters["lng"] = lng.value ?? ""
        NetworkManager.instance.paramaters["is_default"] = is_default.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.addresses.rawValue, type: .post, AddAddres.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addressdata.send(model)
        }).store(self)
        
    }
    func editaddress() {
        //NetworkManager.instance.paramaters["street"] = street.value ?? ""
        if statesId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["state_id"] = statesId.value ?? 0
        }
        if city_id.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["city_id"] = city_id.value ?? 0
        }
        if district.value ?? "" != "" {
            NetworkManager.instance.paramaters["district"] = district.value ?? ""
        }
        NetworkManager.instance.paramaters["lat"] = lat.value ?? ""
        NetworkManager.instance.paramaters["lng"] = lng.value ?? ""
        NetworkManager.instance.paramaters["is_default"] = is_default.value ?? 0
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.addresses.rawValue)/\(addressId.value ?? 0)/update", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.editsdata.send(model)
        }).store(self)
        
    }
}
