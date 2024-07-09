//
//  HomeVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController {
    @IBOutlet weak var newsTbl: UITableView!
    @IBOutlet weak var matchesCollection: UICollectionView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubSelectBtn: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var moreNewsLbl: UILabel!
    @IBOutlet weak var MoreMatchLbl: UILabel!
    @IBOutlet weak var coverView: UIView!
    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?
}

// MARK: - ...  LifeCycle
extension HomeVC {
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
extension HomeVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension HomeVC {
}
