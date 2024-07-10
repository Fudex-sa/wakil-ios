//
//  EditprofileVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditprofileVC: BaseController {
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var mapLbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var phoneTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var userTxf: UITextField!
    var viewModel: EditprofileViewModel?
    var coordinator: EditprofileCoordinator?
}

// MARK: - ...  LifeCycle
extension EditprofileVC {
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
extension EditprofileVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension EditprofileVC {
}
