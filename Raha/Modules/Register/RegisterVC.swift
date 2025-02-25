//
//  RegisterVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class RegisterVC: BaseController {
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var CheckBtn: CheckBoxButton!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var nameTxf: UITextField!
    var viewModel: RegisterViewModel?
    var coordinator: RegisterCoordinator?
}

// MARK: - ...  LifeCycle
extension RegisterVC {
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
extension RegisterVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension RegisterVC {
}
