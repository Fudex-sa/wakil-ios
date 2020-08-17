//
//  client_notifications_Cell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class client_notifications_Cell: UITableViewCell {

    
    @IBOutlet weak var notification_image: UIImageView!
    
    @IBOutlet weak var notification_title: UILabel!
    
    @IBOutlet weak var notification_body: UILabel!
    
    
    @IBOutlet weak var new_notification: UILabel!
    @IBOutlet weak var notification_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        new_notification.layer.cornerRadius = new_notification.frame.width / 2
        new_notification.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
