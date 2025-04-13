//
//  GiftVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol GiftVCDelegate: AnyObject {
    func done(model : GiftModel)

}
// MARK: - ...  ViewController - Vars
class GiftVC: BaseController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addressTxf: UITextField!
    @IBOutlet weak var mobileTXf: UITextField!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var maleLbl: UILabel!
    @IBOutlet weak var femaleRadio: RadioButton!
    @IBOutlet weak var maleRadio: RadioButton!
    var viewModel: GiftViewModel?
    var coordinator: GiftCoordinator?
    var gift : GiftModel = GiftModel.init()
    var delegate: GiftVCDelegate?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(mobileTXf, rules: [GuardRequired()], title: "Mobile number".localized).holdColor()
        validator.setUIType(.message).append(addressTxf, rules: [GuardRequired() ], title: "Address".localized).holdColor()
        validator.setUIType(.message).append(nameTxf, rules: [GuardRequired() ], title: "Name of the person to whom the gift is sent".localized).holdColor()
        return validator
    }()
}

// MARK: - ...  LifeCycle
extension GiftVC {
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
extension GiftVC {
    func setup() {
        maleRadio.onSelect(execute: { [self] in
            femaleRadio.deselect()
            gift.gender = "male"
            maleLbl.textColor = R.color.black1()
            femaleLbl.textColor = R.color.darkgray2()
        })
        femaleRadio.onSelect(execute: { [self] in
            maleRadio.deselect()
            gift.gender = "female"
            femaleLbl.textColor = R.color.black1()
            maleLbl.textColor = R.color.darkgray2()
        })
        doneBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
//            if self?.viewModel?.stateId.value ?? 0 == 0 {
//                error = "select city".localized
//            }
    
            var phone = self?.mobileTXf.text ?? ""
            if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                if phone.count != 10 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(10)"
                }
            }else {
                if phone.count != 9 {
                    error = "\(error)\n\("Mobile number".localized) \("lenght must be".localized) \(9)"
                }
            }
            if self?.gift.gender ?? "" == "" {
                error = "\(error)\n\("select gender".localized)"
            }
            if error != "" {
                self?.didError(error: error)
            }else {
                if phone.count > 3 && phone.prefix(upTo:phone.index(phone.startIndex, offsetBy: 1)) == "0" {
                    let index = phone.index(phone.startIndex, offsetBy: 1)
                    phone = String(phone.suffix(from: index))
                    self?.gift.phone = phone
                }else {
                    self?.gift.phone = self?.mobileTXf.text ?? ""
                }
                self?.gift.name = self?.nameTxf.text ?? ""
                self?.gift.address = self?.addressTxf.text ?? ""
                self?.delegate?.done(model: (self?.gift)!)
                self?.dismiss(animated: true, completion: nil)
            }
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension GiftVC {
}
