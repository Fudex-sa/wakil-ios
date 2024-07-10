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
