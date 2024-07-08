//
//  SignupVC.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SignupVC: BaseController {
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var checkBtn: CheckBoxButton!
    @IBOutlet weak var confirmEyeBtn: UIButton!
    @IBOutlet weak var confirmPassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var mapLbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var userTxf: UITextField!
    var viewModel: SignupViewModel?
    var coordinator: SignupCoordinator?
}

// MARK: - ...  LifeCycle
extension SignupVC {
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
extension SignupVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension SignupVC {
}
