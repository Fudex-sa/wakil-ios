//
//  DeleteaccountpopupViewModel.swift
//  Wndo
//
//  Created by Adam on 13/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class DeleteaccountpopupViewModel: BaseViewModel {
    var delete: Publisher<UserRoot> = .init()
}
// MARK: - ...  Presenter Contract
extension DeleteaccountpopupViewModel {
}
// MARK: - ...  Example of network response
extension DeleteaccountpopupViewModel {
    func deleteaccount() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.deleteaccount.rawValue)", type: .get, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.delete.send(model)
        }).store(self)
    }
    
}
