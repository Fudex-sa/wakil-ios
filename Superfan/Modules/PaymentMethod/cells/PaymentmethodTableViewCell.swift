//
//  PaymentmethodTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class PaymentmethodTableViewCell: BaseTableViewCell {
    @IBOutlet weak var doneImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var paymentTbl: UILabel!
    @IBOutlet weak var paymentImg: UIImageView!
    var id = 0
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard var model = model as? PaymentMethodDatum else { return }
        paymentTbl.text = model.name ?? ""
        paymentImg.setImage(url: model.image ?? "")
        if UD.club != nil {
            checkImg.tintColor = UIColor(hex: UD.club?.color ?? "")
        }
        if id == model.id ?? 0 {
            doneImg.isHidden = false
            checkImg.isHidden = false
            containerView.backgroundColor = UIColor(hex: "#E7EFF9")
        }else {
            doneImg.isHidden = true
            checkImg.isHidden = true
            containerView.backgroundColor = R.color.whiteColor()
        }
    }
}
