//
//  NewsTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class NewsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    @IBOutlet weak var ContainerView: UIView!
    
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var newImg: UIImageView!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? NewsModelData else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.photo ?? "")
        timeLbl.text = model.date ?? ""
        titlelbl.text = model.title ?? ""
        newImg.setImage(url: model.backgrouds ?? "")
        if model.backgrouds ?? "" == "" {
            imageHight.constant = 0
        }else {
            imageHight.constant = 134
        }
    }
}
