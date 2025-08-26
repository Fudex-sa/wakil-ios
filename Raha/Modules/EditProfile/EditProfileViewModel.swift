//
//  EditProfileViewModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewModel
class EditProfileViewModel: BaseViewModel {
    var name: Publisher<String> = .init()
    var gender: Publisher<String> = .init()
    var userImg: Publisher<UIImage> = .init()
    var userdata: Publisher<ProfileModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension EditProfileViewModel {
}
// MARK: - ...  Example of network response
extension EditProfileViewModel {
    func updateprofile() {
        NetworkManager.instance.paramaters["name"] = name.value ?? ""
        NetworkManager.instance.paramaters["gender"] = gender.value ?? ""
        var images: [String: UIImage] = [:]
        images["avatar"] = userImg.value ?? UIImage()
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
