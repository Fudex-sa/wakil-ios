//
//  SelectservicesTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class SelectservicesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var priceImg: UIImageView!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var providerLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? Service else { return }
        titleLbl.text = model.name ?? ""
        priceLbl.text = model.price ?? ""
        providerLbl.text = model.providerType ?? ""
        timeLbl.text = model.duration ?? ""
        rateLbl.text = model.rate?.string ?? ""
        if Localizer.current == .arabic {
            priceImg.isHidden = false
            currencyLbl.isHidden = true
        }else {
            priceImg.isHidden = true
            currencyLbl.isHidden = false
        }
        if model.rate ?? 0 == 0 {
            rateLbl.isHidden = true
            starImg.isHidden = true
        }else {
            rateLbl.isHidden = false
            starImg.isHidden = false
        }
    }
}
