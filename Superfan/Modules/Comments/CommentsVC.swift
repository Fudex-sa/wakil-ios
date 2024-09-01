//
//  CommentsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CommentsVC: BaseController {
    @IBOutlet weak var commentsTbl: UITableView!
    @IBOutlet weak var commentTxf: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    var viewModel: CommentsViewModel?
    var coordinator: CommentsCoordinator?
}

// MARK: - ...  LifeCycle
extension CommentsVC {
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
extension CommentsVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension CommentsVC {
}
