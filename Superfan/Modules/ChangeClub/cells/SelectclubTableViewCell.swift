//
//  SelectclubTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class SelectclubTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? SelectclubDatum else { return }
        clubLbl.text = model.name ?? ""
        clubImg.setImage(url: model.photo ?? "")
        if UD.club?.id ?? 0 == model.id ?? 0 {
            selectImg.image = UIImage(named: "radioon")
        }else {
            selectImg.image = UIImage(named: "radiooff")
        }
        
    }
}
