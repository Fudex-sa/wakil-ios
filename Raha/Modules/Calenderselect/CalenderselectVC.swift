//
//  CalenderselectVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol CalenderselectVCDelegate: AnyObject {
    func done(model : Date)

}
// MARK: - ...  ViewController - Vars
class CalenderselectVC: BaseController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    var viewModel: CalenderselectViewModel?
    var coordinator: CalenderselectCoordinator?
    var delegate: CalenderselectVCDelegate?
    var date: Date = Date()
}

// MARK: - ...  LifeCycle
extension CalenderselectVC {
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
extension CalenderselectVC {
    func setup() {
        datePicker.minimumDate = Date()
        doneBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.done(model: (self?.date)!)
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        backBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
           let selectedDate = sender.date
           self.date = selectedDate
       }
}
// MARK: - ...  View Contract
extension CalenderselectVC {
}
