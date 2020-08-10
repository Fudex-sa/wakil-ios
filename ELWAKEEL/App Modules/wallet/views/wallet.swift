//
//  wallet.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class wallet: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
