//
//  AddressTableViewCell.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol AddressTableViewCellViewCellDelegate: AnyObject {
    func done(wasPressedOnCell cell: AddressTableViewCell , model : AddressesDatum)

}
class AddressTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var defualtHight: NSLayoutConstraint!
    @IBOutlet weak var defualtLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var locTop: NSLayoutConstraint!
    @IBOutlet weak var checkImg: UIImageView!
    var id = 0
    var delegate: AddressTableViewCellViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? AddressesDatum else { return }
        locLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        if model.isDefault ?? 0 == 1 {
            defualtLbl.isHidden = false
            locTop.constant = 8
        }else {
            defualtLbl.isHidden = true
            locTop.constant = 0
        }
        if model.id ?? -1 == id {
            checkImg.image = R.image.checkbox()
            containerView.backgroundColor = R.color.lightblue()
        }else {
            containerView.backgroundColor = R.color.whiteColor()
            checkImg.image = R.image.uncheckedBox()
        }
        containerView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.done(wasPressedOnCell: self, model: model)
        }).store(self)
       
    }
}
