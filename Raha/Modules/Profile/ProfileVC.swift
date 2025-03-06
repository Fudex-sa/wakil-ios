//
//  ProfileVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProfileVC: BaseController {
    @IBOutlet weak var editPassBtn: UIButton!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailEditBtn: UIButton!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var phoneEditBtn: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
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
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
        setup()
        bind()
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
        viewModel?.getprofile()
    }
    func reload(){
        nameLbl.text = viewModel?.userddata.value?.data?.name ?? ""
        userImg.setImage(url: viewModel?.userddata.value?.data?.photo ?? "")
        phoneLbl.text = viewModel?.userddata.value?.data?.mobile ?? ""
        if viewModel?.userddata.value?.data?.email ?? "" == "" {
            emailLbl.text = "No email has been added yet".localized
        }else {
            emailLbl.text = viewModel?.userddata.value?.data?.email ?? ""
        }

    }
}
// MARK: - ...  View Contract
extension ProfileVC {
}
