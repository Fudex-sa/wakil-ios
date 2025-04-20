//
//  ServicesTableViewCell.swift
//  Raha
//
//  Created by ADAM on 27/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class ServicesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var providerLbl: UILabel!
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? Service else { return }
        titleLbl.text = model.name ?? ""
        priceLbl.text = model.price ?? ""
        providerLbl.text = model.providerType ?? ""
        timeLbl.text = model.duration ?? ""
        rateLbl.text = model.rate?.string ?? ""
        if model.isselect == true {
            selectLbl.text = "Selected".localized
            selectLbl.textColor = R.color.normalblue()
            selectImg.image = R.image.checkBox()
        }else {
            selectLbl.text = "Select Service".localized
            selectLbl.textColor = R.color.black3()
            selectImg.image = R.image.uncheckedBox()
        }
    }
}
