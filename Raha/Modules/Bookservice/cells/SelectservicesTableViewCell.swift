//
//  SelectservicesTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class SelectservicesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
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
    }
}
