//
//  ReservationVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReservationVC: BaseController {
    @IBOutlet weak var orderTbl: UITableView!
    @IBOutlet weak var perviousLineView: UIView!
    @IBOutlet weak var perviousLbl: UILabel!
    @IBOutlet weak var perviousView: UIView!
    @IBOutlet weak var ongoingLineView: UIView!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var ongoingView: UIView!
    @IBOutlet weak var newLineView: UIView!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var newView: UIView!
    var viewModel: ReservationViewModel?
    var coordinator: ReservationCoordinator?
}

// MARK: - ...  LifeCycle
extension ReservationVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
        Constants.index = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ReservationVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ReservationVC {
}
