//
//  NewsViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class NewsViewModel: BaseViewModel , DataSourceViewModel{
    var countryId: Publisher<Int> = .init()
    var clubId: Publisher<Int> = .init()
    var items: Publisher<[NewsModelData]> = .init()
}
// MARK: - ...  ViewModel Contract
extension NewsViewModel {
}
// MARK: - ...  Example of network response
extension NewsViewModel {
    func fetchnews() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.news.rawValue, type: .get, NewsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
}
