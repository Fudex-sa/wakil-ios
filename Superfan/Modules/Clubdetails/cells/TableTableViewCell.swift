//
//  TableTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 20/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class TableTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var aqainestLbl: UILabel!
    @IBOutlet weak var forLbl: UILabel!
    @IBOutlet weak var loseLbl: UILabel!
    @IBOutlet weak var drawLbl: UILabel!
    @IBOutlet weak var winLbl: UILabel!
    @IBOutlet weak var playLbl: UILabel!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var numLbl: UILabel!
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? Standing else { return }
        numLbl.text = model.order?.string ?? ""
        clubLbl.text = model.teamName ?? ""
        clubImg.setImage(url: model.teamLogo ?? "")
        playLbl.text = model.played?.string ?? ""
        winLbl.text = model.win?.string ?? ""
        drawLbl.text = model.draw?.string ?? ""
        loseLbl.text = model.lose?.string ?? ""
        forLbl.text = model.goalsIn?.string ?? ""
        aqainestLbl.text = model.goalsOut?.string ?? ""
        if (model.order ?? 0) % 2 == 0 {
            containerView.backgroundColor = R.color.secondary1()
        }else {
            containerView.backgroundColor = R.color.primary1()
        }
    }
}
