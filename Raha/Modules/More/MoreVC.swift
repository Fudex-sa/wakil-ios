//
//  MoreVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MoreVC: BaseController {
    @IBOutlet weak var logoutLbl: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var contactusView: UIView!
    @IBOutlet weak var complainView: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var profileView: UIView!
    var viewModel: MoreViewModel?
    var coordinator: MoreCoordinator?
}

// MARK: - ...  LifeCycle
extension MoreVC {
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
extension MoreVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension MoreVC {
}
