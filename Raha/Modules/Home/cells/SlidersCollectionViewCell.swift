//
//  SlidersCollectionViewCell.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class SlidersCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sliderImg: UIImageView!
    
     func setupcenters() {
        skeleton(view: containerView)
        guard let model = model as? Image else { return }
         sliderImg.setImage(url: model.image ?? "")
    }
}
