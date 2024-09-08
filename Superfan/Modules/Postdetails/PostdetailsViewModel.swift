//
//  PostdetailsViewModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class PostdetailsViewModel: BaseViewModel {
    var postId: Publisher<Int> = .init()
    var postdata: Publisher<PostdetailsModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension PostdetailsViewModel {
}
// MARK: - ...  Example of network response
extension PostdetailsViewModel {
    func getpostdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)", type: .get, PostdetailsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.postdata.send(model)
        }).store(self)
    }
}
