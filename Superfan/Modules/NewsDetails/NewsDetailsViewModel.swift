//
//  NewsDetailsViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class NewsDetailsViewModel: BaseViewModel {
    var newsId: Publisher<Int> = .init()
    var newsdata: Publisher<NewsDetailsModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension NewsDetailsViewModel {
}
// MARK: - ...  Example of network response
extension NewsDetailsViewModel {
    func getnewsdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.news.rawValue)/\(newsId.value ?? 0)", type: .get, NewsDetailsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.newsdata.send(model)
        }).store(self)
    }
}
