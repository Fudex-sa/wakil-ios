//
//  RequestsCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class RequestsCell: UITableViewCell {

    @IBOutlet weak var requestNum: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var reuestNum2: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var des: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
