//
//  FilterServiceVC.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FilterServiceVC: BaseController {
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var star1Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var femaleRadio: RadioButton!
    @IBOutlet weak var maleRadio: RadioButton!
    @IBOutlet weak var centerRadio: RadioButton!
    @IBOutlet weak var homeRadio: RadioButton!
    @IBOutlet weak var typesCollection: UICollectionView!
    var viewModel: FilterServiceViewModel?
    var coordinator: FilterServiceCoordinator?
}

// MARK: - ...  LifeCycle
extension FilterServiceVC {
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
extension FilterServiceVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension FilterServiceVC {
}
