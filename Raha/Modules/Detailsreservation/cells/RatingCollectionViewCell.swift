//
//  RatingCollectionViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class RatingCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? RatingDatum else { return }
        userImg.setImage(url: model.user?.avatarURL ?? "")
        nameLbl.text = model.user?.name ?? ""
        commentLbl.text = model.comment ?? ""
        rateLbl.text = model.rating?.string ?? ""
    }
   

}
