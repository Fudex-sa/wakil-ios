//
//  AddPostViewModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewModel
class AddPostViewModel: BaseViewModel {
    var postId: Publisher<Int> = .init()
    var mediaId: Publisher<Int> = .init()
    var des: Publisher<String> = .init()
    var files: Publisher<[AddPostModel]> = .init()
    var addpostdata: Publisher<UserRoot> = .init()
    var deletedata: Publisher<DeletePost> = .init()

}
// MARK: - ...  ViewModel Contract
extension AddPostViewModel {
}
// MARK: - ...  Example of network response
extension AddPostViewModel {
    func addpost() {
        NetworkManager.instance.paramaters["description"] = des.value ?? ""
        var index = 0
        var images: [String: URL] = [:]
        for item in files.value ?? [] {
            NetworkManager.instance.paramaters["files[\(index)][type]"] = item.type
            if item.type == "videos" {
                images["files[\(index)][value]"] = item.uri

            }else {
                images["files[\(index)][value]"] = URL(string: item.path)
            }
            index = index + 1
        }
        NetworkManager.instance.uploadFiles(NetworkConfigration.EndPoint.posts.rawValue, type: .post,file: images, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addpostdata.send(model)
        }).store(self)
        
    }
    func editpost() {
        NetworkManager.instance.paramaters["description"] = des.value ?? ""
        var index = 0
        var images: [String: URL] = [:]
        for item in files.value ?? [] {
            NetworkManager.instance.paramaters["files[\(index)][type]"] = item.type
            if item.type == "videos" {
                images["files[\(index)][value]"] = item.uri

            }else {
                images["files[\(index)][value]"] = URL(string: item.path)
            }
            index = index + 1
        }
        NetworkManager.instance.uploadFiles("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)", type: .post,file: images, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.addpostdata.send(model)
        }).store(self)
        
    }
    func deletemedia() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.deletemedia.rawValue)/\(mediaId.value ?? 0)/delete", type: .post, DeletePost.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.deletedata.send(model)
        }).store(self)
    }
}
