//
//  LoginVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class LoginVC: BaseController {
    @IBOutlet weak var regBtn: UILabel!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var loginTxf: UITextField!
    @IBOutlet weak var langView: UIView!
    var viewModel: LoginViewModel?
    var coordinator: LoginCoordinator?
}

// MARK: - ...  LifeCycle
extension LoginVC {
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
extension LoginVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension LoginVC {
}
