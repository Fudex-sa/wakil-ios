//
//  SlotsCollectionViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class SlotsCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var slotLbl: UILabel!
    
    override func setup() {
        super.setup()
        guard let model = model as? Slot else { return }
        slotLbl.text = model.from ?? ""
        if model.active ?? false {
            if model.isselect ?? false {
                slotLbl.textColor = R.color.normalblue()
            }else {
                slotLbl.textColor = R.color.black1()
            }
        }else {
            slotLbl.textColor = UIColor(hex: "#CCCCCC")
        }
    }
}
