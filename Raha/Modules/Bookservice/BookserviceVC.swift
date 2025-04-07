//
//  BookserviceVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class BookserviceVC: BaseController {
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var slotsTbl: UITableView!
    @IBOutlet weak var calenderView: HorizontalCalendarView!
    @IBOutlet weak var addGiftBtn: UIButton!
    @IBOutlet weak var changeAddressBtn: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var visitLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var serviceTbl: UITableView!
    var viewModel: BookserviceViewModel?
    var coordinator: BookserviceCoordinator?
}

// MARK: - ...  LifeCycle
extension BookserviceVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension BookserviceVC {
    func setup() {
        calenderView.onDateSelected = { selectedDate in
            print("You picked: \(selectedDate)")
        }

    }
}
// MARK: - ...  View Contract
extension BookserviceVC {
}
