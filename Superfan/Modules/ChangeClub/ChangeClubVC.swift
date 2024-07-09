//
//  ChangeClubVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ChangeClubVC: BaseController {
    @IBOutlet weak var clubsTbl: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: ChangeClubViewModel?
    var coordinator: ChangeClubCoordinator?
}

// MARK: - ...  LifeCycle
extension ChangeClubVC {
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
extension ChangeClubVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ChangeClubVC {
}
