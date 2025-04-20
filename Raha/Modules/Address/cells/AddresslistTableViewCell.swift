//
//  AddresslistTableViewCell.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol AddresslistTableViewCellDelegate: AnyObject {
    func edit(wasPressedOnCell cell: AddresslistTableViewCell , model : AddressesDatum)
    func delete(wasPressedOnCell cell: AddresslistTableViewCell , model : AddressesDatum)

}
class AddresslistTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var defualtLbl: UILabel!
    @IBOutlet weak var defultBtn: UIButton!
    var delegate: AddresslistTableViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? AddressesDatum else { return }
        titleLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        if model.isDefault ?? 0 == 1 {
            deleteBtn.isHidden = true
            defualtLbl.isHidden = false
            defultBtn.setImage(R.image.toggle(), for: .normal)
        }else {
            deleteBtn.isHidden = false
            defualtLbl.isHidden = true
            defultBtn.setImage(R.image.toggle2(), for: .normal)
        }
        editBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.edit(wasPressedOnCell: self, model: model)
        }).store(self)
        deleteBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.delete(wasPressedOnCell: self, model: model)
        }).store(self)
    }
}
