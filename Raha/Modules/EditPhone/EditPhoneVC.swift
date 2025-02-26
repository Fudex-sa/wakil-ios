//
//  EditPhoneVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditPhoneVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var phoneTxf: UITextField!
    var viewModel: EditPhoneViewModel?
    var coordinator: EditPhoneCoordinator?
}

// MARK: - ...  LifeCycle
extension EditPhoneVC {
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
extension EditPhoneVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension EditPhoneVC {
}
