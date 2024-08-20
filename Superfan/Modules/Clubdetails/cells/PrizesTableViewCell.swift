//
//  PrizesTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 20/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class PrizesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? Prize else { return }
        titleLbl.text = model.name ?? ""
    }
}
