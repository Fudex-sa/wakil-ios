//
//  MypostsViewModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class MypostsViewModel: BaseViewModel , DataSourceViewModel{
    var postId: Publisher<Int> = .init()
    var items: Publisher<[PostsDatum]> = .init()
    var likedata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension MypostsViewModel {
}
// MARK: - ...  Example of network response
extension MypostsViewModel {
    func fetchposts() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.myposts.rawValue, type: .get, PostsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func fetchposts1() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.posts.rawValue, type: .get, PostsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func likepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/like", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
    }
    func unlikepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/disLike", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
       
    }
}
