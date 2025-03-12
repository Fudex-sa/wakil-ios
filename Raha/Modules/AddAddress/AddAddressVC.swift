//
//  AddAddressVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AddAddressVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var defaultBtn: CheckBoxButton!
    @IBOutlet weak var hayTxf: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var streetTxf: UITextField!
    var viewModel: AddAddressViewModel?
    var coordinator: AddAddressCoordinator?
}

// MARK: - ...  LifeCycle
extension AddAddressVC {
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
extension AddAddressVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension AddAddressVC {
}
