//
//  SelectLanguageVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SelectLanguageVC: BaseController {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var englishRadio: RadioButton!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arabicRadio: RadioButton!
    @IBOutlet weak var arabicView: UIView!
    var viewModel: SelectLanguageViewModel?
    var coordinator: SelectLanguageCoordinator?
}

// MARK: - ...  LifeCycle
extension SelectLanguageVC {
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
extension SelectLanguageVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension SelectLanguageVC {
}
