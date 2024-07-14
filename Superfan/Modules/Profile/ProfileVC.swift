//
//  ProfileVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProfileVC: BaseController {
    @IBOutlet weak var editPhoneBtn: UIButton!
    @IBOutlet weak var editEmailBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var editPassBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var mapLbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var userTxf: UITextField!
    var viewModel: ProfileViewModel?
    var coordinator: ProfileCoordinator?
}

// MARK: - ...  LifeCycle
extension ProfileVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.userddata.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension ProfileVC {
    func setup() {
        if UD.user?.data?.user?.isSocial ?? 0 == 1 {
            editEmailBtn.isHidden = true
            editPassBtn.isHidden = true
        }else {
            editEmailBtn.isHidden = false
            editPassBtn.isHidden = false
        }
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        startLoading()
        viewModel?.getprofile()
        editBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.editprofile()
        }).store(self)
        editPhoneBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.editphone()
        }).store(self)
        editEmailBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.editemail()
        }).store(self)
        editPassBtn.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.editpassword()
        }).store(self)
    }
    func reload(){
        stopLoading()
        userTxf.text = viewModel?.userddata.value?.data?.name ?? ""
        phoneTxf.text = viewModel?.userddata.value?.data?.mobile ?? ""
        emailTxf.text = viewModel?.userddata.value?.data?.email ?? ""
        mapLbl.text = viewModel?.userddata.value?.data?.location ?? ""
        if viewModel?.userddata.value?.data?.isSocial ?? 0 == 1 {
            editPassBtn.isHidden = true
            editPassBtn.isHidden = true
        }else {
            editPassBtn.isHidden = false
            editPassBtn.isHidden = false
        }
        userImg.setImage(url: viewModel?.userddata.value?.data?.photo ?? "")
    }
}
// MARK: - ...  View Contract
extension ProfileVC {
}
