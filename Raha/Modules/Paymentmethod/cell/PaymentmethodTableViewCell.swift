//
//  PaymentmethodTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 21/09/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol PaymentmethodTableViewCellDelegate: AnyObject {
    func done(wasPressedOnCell cell: PaymentmethodTableViewCell , model : PaymentMethod)

}
class PaymentmethodTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var paymentImg: UIImageView!
    var id = 0
    var delegate: PaymentmethodTableViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? PaymentMethod else { return }

        if model.paymentMethodID ?? -1 == id {
            checkImg.image = R.image.checkbox()
            containerView.backgroundColor = R.color.lightblue()
        }else {
            containerView.backgroundColor = R.color.whiteColor()
            checkImg.image = R.image.uncheckedBox()
        }
        if Localizer.current == .arabic {
            titleLbl.text = model.paymentMethodAr ?? ""
        }else {
            titleLbl.text = model.paymentMethodEn ?? ""
        }
        paymentImg.setImage(url: model.imageURL ?? "")
        containerView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.done(wasPressedOnCell: self, model: model)
        }).store(self)
       
    }
    
}
