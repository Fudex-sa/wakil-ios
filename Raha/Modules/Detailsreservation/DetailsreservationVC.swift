//
//  DetailsreservationVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class DetailsreservationVC: BaseController {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var userRateLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nameRateLbl: UILabel!
    @IBOutlet weak var userRateImg: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateSpaceView: UIView!
    @IBOutlet weak var suggestionBtn: UIButton!
    @IBOutlet weak var suggestionView: UIView!
    @IBOutlet weak var suggestionSpaceView: UIView!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameGiftLbl: UILabel!
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var giftSpaceView: UIView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var servicesTbl: UITableView!
    @IBOutlet weak var copyView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var viewModel: DetailsreservationViewModel?
    var coordinator: DetailsreservationCoordinator?
}

// MARK: - ...  LifeCycle
extension DetailsreservationVC {
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
extension DetailsreservationVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension DetailsreservationVC {
}
