//
//  provider_Notifications_Cell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class provider_Notifications_Cell: UITableViewCell {
    @IBOutlet weak var Notification_image: UIImageView!
    @IBOutlet weak var Notification_title: UILabel!
    @IBOutlet weak var Notification_Body: UILabel!
    @IBOutlet weak var Notification_Time: UILabel!
    @IBOutlet weak var new: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    new.layer.cornerRadius = new.frame.width / 2
        new.layer.masksToBounds = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
