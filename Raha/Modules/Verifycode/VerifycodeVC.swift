//
//  VerifycodeVC.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class VerifycodeVC: BaseController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var verfiy4Txf: UITextField!
    @IBOutlet weak var verfiy3Txf: UITextField!
    @IBOutlet weak var verfiy2Txf: UITextField!
    @IBOutlet weak var verfiy1Txf: UITextField!
    @IBOutlet weak var phoneLbl: UILabel!
    var viewModel: VerifycodeViewModel?
    var coordinator: VerifycodeCoordinator?
}

// MARK: - ...  LifeCycle
extension VerifycodeVC {
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
extension VerifycodeVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension VerifycodeVC {
}
