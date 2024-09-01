//
//  AddPostVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AddPostVC: BaseController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var gallaryCollection: UICollectionView!
    @IBOutlet weak var vedioView: UIView!
    @IBOutlet weak var gallayView: UIView!
    @IBOutlet weak var desTxf: UITextView!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    var viewModel: AddPostViewModel?
    var coordinator: AddPostCoordinator?
}

// MARK: - ...  LifeCycle
extension AddPostVC {
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
extension AddPostVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension AddPostVC {
}
