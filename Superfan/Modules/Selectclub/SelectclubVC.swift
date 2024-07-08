//
//  SelectclubVC.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SelectclubVC: BaseController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var clubsTbl: UITableView!

    var viewModel: SelectclubViewModel?
    var coordinator: SelectclubCoordinator?
}

// MARK: - ...  LifeCycle
extension SelectclubVC {
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
extension SelectclubVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension SelectclubVC {
}
