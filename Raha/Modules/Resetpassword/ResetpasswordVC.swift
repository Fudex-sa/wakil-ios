//
//  ResetpasswordVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ResetpasswordVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var confirmeyeBtn: UIButton!
    @IBOutlet weak var confirmpassTxf: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var passTxf: UITextField!
    var viewModel: ResetpasswordViewModel?
    var coordinator: ResetpasswordCoordinator?
}

// MARK: - ...  LifeCycle
extension ResetpasswordVC {
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
extension ResetpasswordVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ResetpasswordVC {
}
