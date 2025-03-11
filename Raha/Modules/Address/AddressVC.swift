//
//  AddressVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AddressVC: BaseController {
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addressLTbl: UITableView!
    var viewModel: AddressViewModel?
    var coordinator: AddressCoordinator?
}

// MARK: - ...  LifeCycle
extension AddressVC {
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
extension AddressVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension AddressVC {
}
