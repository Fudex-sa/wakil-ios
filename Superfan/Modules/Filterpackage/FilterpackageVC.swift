//
//  FilterpackageVC.swift
//  Superfan
//
//  Created by ADAM on 08/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol FilterpackageVCDelegate: AnyObject {
    func doneFilter(price: String , duaration: String)
}
// MARK: - ...  ViewController - Vars
class FilterpackageVC: BaseController {
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var twelveBtn: RadioButton!
    @IBOutlet weak var twelveView: UIView!
    @IBOutlet weak var sexBtn: RadioButton!
    @IBOutlet weak var sexView: UIView!
    @IBOutlet weak var threeBtn: RadioButton!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var lowestBtn: RadioButton!
    @IBOutlet weak var lowestView: UIView!
    @IBOutlet weak var highestBtn: RadioButton!
    @IBOutlet weak var highestView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: FilterpackageViewModel?
    var coordinator: FilterpackageCoordinator?
    weak var delegate: FilterpackageVCDelegate?
    var price = ""
    var duration = ""
}

// MARK: - ...  LifeCycle
extension FilterpackageVC {
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
extension FilterpackageVC {
    func setup() {
        changeColoe()
        highestView.publisherGesture.listen(on: {[weak self] _ in
            self?.highestBtn.select()
            self?.lowestBtn.deselect()
            self?.price = "total_price_up"
        }).store(self)
        lowestView.publisherGesture.listen(on: {[weak self] _ in
            self?.lowestBtn.select()
            self?.highestBtn.deselect()
            self?.price = "total_price_down"
        }).store(self)
        threeView.publisherGesture.listen(on: {[weak self] _ in
            self?.threeBtn.select()
            self?.sexBtn.deselect()
            self?.twelveBtn.deselect()
            self?.duration = "3"
        }).store(self)
        sexView.publisherGesture.listen(on: {[weak self] _ in
            self?.sexBtn.select()
            self?.threeBtn.deselect()
            self?.twelveBtn.deselect()
            self?.duration = "6"
        }).store(self)
        twelveView.publisherGesture.listen(on: {[weak self] _ in
            self?.twelveBtn.select()
            self?.sexBtn.deselect()
            self?.threeBtn.deselect()
            self?.duration = "12"
        }).store(self)
        clearBtn.publisher.listen(on: {[weak self] _ in
            self?.threeBtn.deselect()
            self?.sexBtn.deselect()
            self?.twelveBtn.deselect()
            self?.highestBtn.deselect()
            self?.lowestBtn.deselect()
            self?.duration = ""
            self?.price = ""
        }).store(self)
        confirmBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.doneFilter(price: self?.price ?? "", duaration: self?.duration ?? "")
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            confirmBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
            clearBtn.borderColor = UIColor(hex: UD.club?.color ?? "")
            clearBtn.setTitleColor(UIColor(hex: UD.club?.color ?? ""), for: .normal)
        }
    }
}
// MARK: - ...  View Contract
extension FilterpackageVC {
}
