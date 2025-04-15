//
//  RatingPopupViewModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class RatingPopupViewModel: BaseViewModel {
    var rate: Publisher<String> = .init()
    var comment: Publisher<String> = .init()
    var orderId: Publisher<Int> = .init()
    var ratedata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension RatingPopupViewModel {
}
// MARK: - ...  Example of network response
extension RatingPopupViewModel {
    func fetchrate() {
        NetworkManager.instance.paramaters["comment"] = comment.value ?? ""
        NetworkManager.instance.paramaters["rating"] = rate.value ?? ""
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.createorder.rawValue)/\(orderId.value ?? 0)/rate", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.ratedata.send(model)
        }).store(self)
    }
}
