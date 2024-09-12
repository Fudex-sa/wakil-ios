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
    var type: Publisher<String> = .init()
    var postId: Publisher<Int> = .init()
    var commentId: Publisher<Int> = .init()
    var items: Publisher<[CommentsDatum]> = .init()
    var likedata: Publisher<UserRoot> = .init()
    var deletedata: Publisher<DeletePost> = .init()
    var addcommentdata: Publisher<UserRoot> = .init()
}
// MARK: - ...  ViewModel Contract
extension CommentsViewModel {
}
// MARK: - ...  Example of network response
extension CommentsViewModel {
    func fetchcomments() {
        var method = ""
        if type.value ?? "" == "reply"{
           method = "\(NetworkConfigration.EndPoint.comments.rawValue)/\(postId.value ?? 0)/comments"
        }else {
            method = "\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comments"
        }
        NetworkManager.instance.request(method, type: .get, CommentsModel.self)?.response(error: { [weak self] error in
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
        var method = ""
        if type.value ?? "" == "reply"{
           method = "\(NetworkConfigration.EndPoint.comments.rawValue)/\(postId.value ?? 0)/comment"
        }else {
            method = "\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comment"
        }
        NetworkManager.instance.request(method, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addcommentdata.send(model)
        }).store(self)
    }
    func editomments() {
        NetworkManager.instance.paramaters["comment"] = comment.value ?? ""
        var method = ""
        if type.value ?? "" == "reply"{
           method = "\(NetworkConfigration.EndPoint.comments.rawValue)/\(commentId.value ?? 0)/edit"
        }else {
            method = "\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comments/\(commentId.value ?? 0)/edit"
        }
        NetworkManager.instance.request(method, type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addcommentdata.send(model)
        }).store(self)
    }
    func deletecomments() {
        var method = ""
        if type.value ?? "" == "reply"{
           method = "\(NetworkConfigration.EndPoint.comments.rawValue)/\(commentId.value ?? 0)/delete"
        }else {
            method = "\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/comments/\(commentId.value ?? 0)/delete"
        }
        NetworkManager.instance.request(method, type: .post, DeletePost.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deletedata.send(model)
        }).store(self)
    }
    func likepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.comments.rawValue)/\(commentId.value ?? 0)/like", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
    }
    func unlikepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.comments.rawValue)/\(commentId.value ?? 0)/disLike", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
       
    }
}
