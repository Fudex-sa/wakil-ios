//
//  PlayerteamTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 28/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class PlayerteamTableViewCell: BaseTableViewCell {
    @IBOutlet weak var contianerView: UIView!
    @IBOutlet weak var playerLbl: UILabel!
    override func setup() {
        super.setup()
        guard let model = model as? ScorersModel else { return }
        playerLbl.text =  "\(model.time ?? "")' \(model.player_name ?? "")"
    }
}
