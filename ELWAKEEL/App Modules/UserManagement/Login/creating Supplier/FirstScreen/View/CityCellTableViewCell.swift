//
//  CityCellTableViewCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
