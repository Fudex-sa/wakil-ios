//
//  ClubdetailsVC.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ClubdetailsVC: BaseController {
    var viewModel: ClubdetailsViewModel?
    var coordinator: ClubdetailsCoordinator?
}

// MARK: - ...  LifeCycle
extension ClubdetailsVC {
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
extension ClubdetailsVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ClubdetailsVC {
}
