//
//  FaqViewModel.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class FaqViewModel: BaseViewModel ,DataSourceViewModel {
    var items: Publisher<[faqdataModel]> = .init()
}
// MARK: - ...  ViewModel Contract
extension FaqViewModel {
}
// MARK: - ...  Example of network response
extension FaqViewModel {
    func fetchfaq() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.faqs.rawValue, type: .get, FAQModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}
