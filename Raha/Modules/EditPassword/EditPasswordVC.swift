//
//  EditPasswordVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditPasswordVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var neweyeBtn: UIButton!
    @IBOutlet weak var newpassTxf: UITextField!
    @IBOutlet weak var oldeyeBtn: UIButton!
    @IBOutlet weak var oldpassTxf: UITextField!
    var viewModel: EditPasswordViewModel?
    var coordinator: EditPasswordCoordinator?
}

// MARK: - ...  LifeCycle
extension EditPasswordVC {
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
extension EditPasswordVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension EditPasswordVC {
}
