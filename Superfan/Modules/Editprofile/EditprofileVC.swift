//
//  EditprofileVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditprofileVC: BaseController {
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var mapLbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var userTxf: UITextField!
    var viewModel: EditprofileViewModel?
    var coordinator: EditprofileCoordinator?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(userTxf, rules: [GuardRequired() ], title: "Username".localized).holdColor()
        return validator
    }()
    var user: ProfileModel?
    var picker: GalleryPickerHelper?
    var photoURL: URL?
    var registertype = 0
}

// MARK: - ...  LifeCycle
extension EditprofileVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator = .init()
        coordinator?.view = self
        actions()
        bind()
        self.tabBarController?.tabBar.isHidden = true
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
extension EditprofileVC {
    func setup() {
        userTxf.text = user?.data?.name ?? ""
        mapLbl.text = user?.data?.location ?? ""
        userImg.setImage(url: user?.data?.photo ?? "")
        viewModel?.lat.send(user?.data?.lat ?? "")
        viewModel?.lng.send(user?.data?.lng ?? "")
        changeColoe()
    }
    func actions(){
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            self.photoURL = url
                    
        }
        picker?.onPickImage = { [self] image in
            self.userImg.image = image
        }
        editImgBtn.publisher.listen(on: {[weak self] _ in
            self?.picker?.pick(in: self)
        }).store(self)
        mapView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.locate()
        }).store(self)
        editBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
//            if self?.viewModel?.lat.value ?? "" == "" {
//                error = "Locate on map".localized
//            }
            if error == "" {
                self?.viewModel?.name.send(self?.userTxf.text ?? "")
                self?.viewModel?.userImg.send(self?.userImg.image ?? UIImage())
                self?.viewModel?.location.send(self?.mapLbl.text ?? "")
                self?.startLoading()
                self?.viewModel?.updateprofile()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            editBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension EditprofileVC {
}
