//
//  MatchdetailsTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class MatchdetailsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var reulst1Lbl: UILabel!
    override func setup() {
        super.setup()
        guard let model = model as? statistecModel else { return }
        titleLbl.text = model.title
        resultLbl.text = model.result1
        reulst1Lbl.text = model.result2
    }
}
