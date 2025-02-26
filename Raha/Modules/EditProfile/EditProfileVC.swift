//
//  EditProfileVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditProfileVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var imageEditBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    var viewModel: EditProfileViewModel?
    var coordinator: EditProfileCoordinator?
}

// MARK: - ...  LifeCycle
extension EditProfileVC {
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
extension EditProfileVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension EditProfileVC {
}
