//
//  BookserviceViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class BookserviceViewModel: BaseViewModel {
    var centerId: Publisher<Int> = .init()
    var date: Publisher<String> = .init()
    var services: Publisher<[Service]> = .init()
    var location_type: Publisher<String> = .init()
    var address_id: Publisher<Int> = .init()
    var mobile: Publisher<String> = .init()
    var address: Publisher<String> = .init()
    var name: Publisher<String> = .init()
    var payment_method: Publisher<String> = .init()
    var price: Publisher<String> = .init()
    var gender: Publisher<String> = .init()
    var slots: Publisher<[SlotsDatum]> = .init()
    var slotsdetails: Publisher<SlotsModel> = .init()
    var createorder: Publisher<BookserviceModel> = .init()

}
// MARK: - ...  ViewModel Contract
extension BookserviceViewModel {
}
// MARK: - ...  Example of network response
extension BookserviceViewModel {
    func fetchcentersdetails() {
        NetworkManager.instance.paramaters["date"] = date.value ?? ""
        NetworkManager.instance.paramaters["branch_id"] = centerId.value ?? 0
        var item = 0
        for index in services.value ?? [] {
            NetworkManager.instance.paramaters["service_ids[\(item)]"] = index.id ?? 0
            item = item + 1
        }
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.slots.rawValue)", type: .get, SlotsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.slotsdetails.send(model)
        }).store(self)
    }
    
    func makecreateorder() {
        if name.value ?? "" != "" {
            NetworkManager.instance.paramaters["name"] = name.value ?? ""
            NetworkManager.instance.paramaters["mobile"] = mobile.value ?? ""
            NetworkManager.instance.paramaters["gender"] = gender.value ?? ""
            NetworkManager.instance.paramaters["address"] = address.value ?? ""
            NetworkManager.instance.paramaters["is_gift"] = 1
        }else {
            NetworkManager.instance.paramaters["is_gift"] = 0
        }
        NetworkManager.instance.paramaters["location_type"] = location_type.value ?? ""
        if location_type.value ?? "" == "home" {
            NetworkManager.instance.paramaters["address_id"] = address_id.value ?? 0
        }
        NetworkManager.instance.paramaters["payment_method"] = payment_method.value ?? ""
        NetworkManager.instance.paramaters["price"] = price.value ?? ""
        NetworkManager.instance.paramaters["date"] = DateHelper().date(date: date.value ?? "", format: "yyyy-MM-dd", oldFormat: "dd-MM-yyyy") ?? ""
        NetworkManager.instance.paramaters["branch_id"] = centerId.value ?? 0
        var item1 = 0
        for index in slots.value ?? [] {
            for item in index.slots ?? [] {
                if item.isselect ?? false {
                    NetworkManager.instance.paramaters["services[\(item1)][id]"] = index.serviceID ?? 0
                    NetworkManager.instance.paramaters["services[\(item1)][provider_type]"] = index.providerType ?? ""
                    NetworkManager.instance.paramaters["services[\(item1)][duration]"] = index.duration ?? ""
                    NetworkManager.instance.paramaters["services[\(item1)][price]"] = index.price ?? ""
                    NetworkManager.instance.paramaters["services[\(item1)][time]"] = item.from ?? ""
                    NetworkManager.instance.paramaters["services[\(item1)][date]"] = DateHelper().date(date: date.value ?? "", format: "yyyy-MM-dd", oldFormat: "dd-MM-yyyy") ?? ""
                }
            }
           
            item1 = item1 + 1
        }
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.createorder.rawValue)", type: .post, BookserviceModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.createorder.send(model)
        }).store(self)
    }
}
