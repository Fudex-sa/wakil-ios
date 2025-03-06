//
//  LogoutViewModel.swift
//  Raha
//
//  Created by ADAM on 06/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class LogoutViewModel: BaseViewModel {
    var logout: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension LogoutViewModel {
}
// MARK: - ...  Example of network response
extension LogoutViewModel {
    func fetchlogout() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.logout.rawValue)", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.logout.send(model)
        }).store(self)
    }
}
