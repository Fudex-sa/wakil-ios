//
//  SelectonmapVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: - ...  ViewController - Vars
class SelectonmapVC: BaseController {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: SelectonmapViewModel?
    var coordinator: SelectonmapCoordinator?
}

// MARK: - ...  LifeCycle
extension SelectonmapVC {
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
extension SelectonmapVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension SelectonmapVC {
}
