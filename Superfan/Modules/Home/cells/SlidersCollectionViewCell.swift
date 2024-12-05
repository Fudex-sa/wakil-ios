//
//  SlidersCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 04/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class SlidersCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sliderImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var desLbl: UILabel!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? SliderModelData else { return }
        sliderImg.setImage(url: model.file ?? "")
        titleLbl.text = model.title ?? ""
        desLbl.text = model.description ?? ""
    }
}
