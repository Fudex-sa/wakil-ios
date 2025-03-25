//
//  ServicetypeCollectionViewCell.swift
//  Raha
//
//  Created by ADAM on 25/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class ServicetypeCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    var serviceId = 0
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? String else { return }
        titleLbl.text = model
    }
    func setupselect() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? RegisterModel else { return }
        containerView.cornerRadius = 12
        titleLbl.text = model.name ?? ""
        containerView.borderWidth = 1
        if serviceId == model.id ?? 0 {
            containerView.borderColor = R.color.normalblue()
            containerView.backgroundColor = R.color.lightblue()
            titleLbl.textColor = R.color.normalblue()
        }else {
            containerView.borderColor = R.color.lightgray()
            containerView.backgroundColor = R.color.whiteColor()
            titleLbl.textColor = R.color.black3()
        }
    }
}
