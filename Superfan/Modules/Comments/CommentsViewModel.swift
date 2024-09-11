//
//  CommentsViewModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class CommentsViewModel: BaseViewModel , DataSourceViewModel{
    var comment: Publisher<String> = .init()
    var postId: Publisher<Int> = .init()
    var items: Publisher<[CommentsDatum]> = .init()
    var likedata: Publisher<UserRoot> = .init()
    var addcommentdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension CommentsViewModel {
}
// MARK: - ...  Example of network response
extension CommentsViewModel {
    func fetchcomments() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comments", type: .get, CommentsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func addcomments() {
        NetworkManager.instance.paramaters["comment"] = comment.value ?? ""
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comment", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addcommentdata.send(model)
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
