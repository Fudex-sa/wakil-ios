//
//  ImagesCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 17/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sliderImg: UIImageView!
    override func setup() {
        skeleton(for: containerView)
        super.setup()
        guard let model = model as? NewsDetailBackgroud else { return }
        sliderImg.setImage(url: model.image ?? "")
    }
}
