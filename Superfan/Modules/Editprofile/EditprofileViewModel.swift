//
//  EditprofileViewModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewModel
class EditprofileViewModel: BaseViewModel {
    var name: Publisher<String> = .init()
    var lat: Publisher<String> = .init()
    var lng: Publisher<String> = .init()
    var userImg: Publisher<UIImage> = .init()
    var userdata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditprofileViewModel {
}
// MARK: - ...  Example of network response
extension EditprofileViewModel {
    func updateprofile() {
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["lat"] = lat.value ?? ""
        NetworkManager.instance.paramaters["lng"] = lng.value ?? ""
        var images: [String: UIImage] = [:]
        images["photo"] = userImg.value ?? UIImage()
        NetworkManager.instance.uploadMultiImagesWithKey(NetworkConfigration.EndPoint.updateprofile.rawValue, type: .post,files: images, ProfileModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            let user = UD.user
            user?.data?.user = model.data
            UD.user = user
            self?.userdata.send(model)
        }).store(self)
    }
}
