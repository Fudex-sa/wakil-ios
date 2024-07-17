//
//  ClubCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class ClubCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    var clubId = 0
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? SelectclubDatum else { return }
        clubLbl.text = model.name ?? ""
        clubImg.setImage(url: model.photo ?? "")
        if clubId == model.id ?? 0 {
            containerView.borderColor = R.color.primary()
        }else {
            containerView.borderColor = R.color.borderprimary()
        }
        
    }
}
