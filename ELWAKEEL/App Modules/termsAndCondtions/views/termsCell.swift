//
//  termsCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class termsCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
