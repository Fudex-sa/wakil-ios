//
//  ChooseLocMethodVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
protocol ChooseLocMethodVCDelegate: AnyObject {
    func addaddressreturn()
    func currentlocreturn()
    func close()
}
// MARK: - ...  ViewController - Vars
class ChooseLocMethodVC: BaseController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var locBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    var viewModel: ChooseLocMethodViewModel?
    var coordinator: ChooseLocMethodCoordinator?
    var delegate: ChooseLocMethodVCDelegate?
}

// MARK: - ...  LifeCycle
extension ChooseLocMethodVC {
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
extension ChooseLocMethodVC {
    func setup() {
        if #available(iOS 14.0, *) {
            let status = CLLocationManager().authorizationStatus
            if status == .denied || status == .restricted {
                locBtn.isHidden = true
            }
        } else {
            // Fallback on earlier versions
        }
        addBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.addaddressreturn()
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        locBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.currentlocreturn()
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.close()
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension ChooseLocMethodVC {
}
