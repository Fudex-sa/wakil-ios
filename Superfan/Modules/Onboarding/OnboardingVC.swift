//
//  OnboardingVC.swift
//  Wndo
//
//  Created by Adam on 27/07/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class OnboardingVC: BaseController {
    var viewModel: OnboardingViewModel?
    var coordinator: OnboardingCoordinator?
}

// MARK: - ...  LifeCycle
extension OnboardingVC {
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
extension OnboardingVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension OnboardingVC {
}
