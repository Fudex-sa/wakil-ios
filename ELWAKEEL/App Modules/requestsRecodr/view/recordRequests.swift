//
//  recordRequests.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class recordRequests: UITableViewCell {

    @IBOutlet weak var requetNum1: UILabel!
    @IBOutlet weak var requesrNum2: UILabel!
    @IBOutlet weak var requeststatus: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requesrNum2.layer.cornerRadius = requesrNum2.frame.width / 2
        requesrNum2.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
