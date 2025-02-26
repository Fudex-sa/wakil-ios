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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ProfileVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ProfileVC {
}
