//
//  FeaturesTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class FeaturesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard var model = model as? String else { return }
        titleLbl.text = model
    }
}
