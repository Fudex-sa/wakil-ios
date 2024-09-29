//
//  BackstageViewModel.swift
//  Superfan
//
//  Created by ADAM on 12/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class BackstageViewModel: BaseViewModel  , DataSourceViewModel{
    var postId: Publisher<Int> = .init()
    var countryId: Publisher<Int> = .init()
    var clubId: Publisher<Int> = .init()
    var items: Publisher<[PostsDatum]> = .init()
    var likedata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension BackstageViewModel {
}
// MARK: - ...  Example of network response
extension BackstageViewModel {
    func fetchbackstage() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.backstages.rawValue, type: .get, PostsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.items.send(model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.requestFinished.send(true)
        }).store(self)
    }
    func likebackstage() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.backstages.rawValue)/\(postId.value ?? 0)/like", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
    }
    func unlikebackstage() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.backstages.rawValue)/\(postId.value ?? 0)/disLike", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
       
    }
}
