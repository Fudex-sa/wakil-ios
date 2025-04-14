//
//  DetailsreservationTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class DetailsreservationTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var locTypeLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var typeLbl: UILabel!
    var isgift = 0
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? Service else { return }
        durationLbl.text = "\(model.duration ?? "") \("Minute".localized)"
        priceLbl.text = model.price ?? ""
        desLbl.text = model.description ?? ""
        typeLbl.text = model.serviceType ?? ""
        nameLbl.text = model.name ?? ""
        locTypeLbl.text = if model.locationType ?? "" == "home" {"Domestic service".localized}else{"At the center".localized}
        if isgift == 1 {
            giftView.isHidden = false
        }else {
            giftView.isHidden = true
        }
    }
}
