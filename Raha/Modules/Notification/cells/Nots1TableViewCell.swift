//
//  Nots1TableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class Nots1TableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? Notificationdata else { return }
        titleLbl.text = model.title ?? ""
        bodyLbl.text = model.body ?? ""
        timeLbl.text = model.sentAt ?? ""
    }
}
