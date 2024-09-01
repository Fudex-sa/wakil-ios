//
//  PostdetailsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class PostdetailsVC: BaseController {
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    var viewModel: PostdetailsViewModel?
    var coordinator: PostdetailsCoordinator?
}

// MARK: - ...  LifeCycle
extension PostdetailsVC {
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
extension PostdetailsVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension PostdetailsVC {
}
