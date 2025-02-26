//
//  SettingsVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SettingsVC: BaseController {
    @IBOutlet weak var languageLbl: UILabel!
    var viewModel: SettingsViewModel?
    var coordinator: SettingsCoordinator?
}

// MARK: - ...  LifeCycle
extension SettingsVC {
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
extension SettingsVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension SettingsVC {
}
