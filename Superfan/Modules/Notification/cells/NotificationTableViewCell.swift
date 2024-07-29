//
//  NotificationTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 29/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class NotificationTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func setup() {
        skeleton(for: containerView)
        super.setup()
        guard let model = model as? NotificationsDatum else { return }
        dateLbl.text = model.date ?? ""
        titleLbl.text = model.title ?? ""
    }
}
