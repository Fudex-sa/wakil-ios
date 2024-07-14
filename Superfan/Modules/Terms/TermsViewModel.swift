//
//  TermsViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class TermsViewModel: BaseViewModel {
    var setting: Publisher<SettingData> = .init()
}
// MARK: - ...  ViewModel Contract
extension TermsViewModel {
}
// MARK: - ...  Example of network response
extension TermsViewModel {
    func fetchsetting() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.setting.rawValue, type: .get, SettingModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.setting.send(model.data!)
        }).store(self)
    }
}
