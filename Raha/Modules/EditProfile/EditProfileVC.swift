//
//  EditProfileVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditProfileVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var imageEditBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    var viewModel: EditProfileViewModel?
    var coordinator: EditProfileCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(nameTxf, rules: [GuardRequired() ], title: "Name".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
    var picker: GalleryPickerHelper?
    var photoURL: URL?
    var registertype = 0
}

// MARK: - ...  LifeCycle
extension EditProfileVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        actions()
        bind()
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.userdata = .init()
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.userdata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.userdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
        })
    }
}
// MARK: - ...  Functions
extension EditProfileVC {
    func setup() {
        nameTxf.text = user?.data?.name ?? ""
        userImg.setImage(url: user?.data?.avatar ?? "")
    }
    func actions(){
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            self.photoURL = url
                    
        }
        picker?.onPickImage = { [self] image in
            self.userImg.image = image
        }
        imageEditBtn.publisher.listen(on: {[weak self] _ in
            self?.picker?.pick(in: self)
        }).store(self)
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
//            if self?.viewModel?.lat.value ?? "" == "" {
//                error = "Locate on map".localized
//            }
            if error == "" {
                self?.viewModel?.name.send(self?.nameTxf.text ?? "")
                self?.viewModel?.userImg.send(self?.userImg.image ?? UIImage())
                self?.startLoading()
                self?.viewModel?.updateprofile()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension EditProfileVC {
}
