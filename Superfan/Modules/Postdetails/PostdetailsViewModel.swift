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
    var deletedata: Publisher<DeletePost> = .init()
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
    func getbackstagesdetails() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.backstages.rawValue)/\(postId.value ?? 0)", type: .get, PostdetailsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.postdata.send(model)
        }).store(self)
    }
    func deletepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/delete", type: .post, DeletePost.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deletedata.send(model)
        }).store(self)
    }
}
