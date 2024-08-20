//
//  PlayersCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 20/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class PlayersCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? Player else { return }
        playerLbl.text = model.playerName ?? ""
        positionLbl.text = model.positionName ?? ""
        playerImg.setImage(url: model.playerImage ?? "")
        flagImg.setImage(url: model.nationalityFlag ?? "")
    }
}
