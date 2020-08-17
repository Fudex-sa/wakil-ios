//
//  provider_log.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class provider_log: UITableViewCell {

    
    @IBOutlet weak var reuest_num: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var request_status: UILabel!
    @IBOutlet weak var rquest_DES: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
