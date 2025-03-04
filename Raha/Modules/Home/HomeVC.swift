//
//  HomeVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController {
    @IBOutlet weak var centerTbl: UITableView!
    @IBOutlet weak var dotsPage: UIPageControl!
    @IBOutlet weak var slidersCollection: UICollectionView!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var notBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
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
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
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
