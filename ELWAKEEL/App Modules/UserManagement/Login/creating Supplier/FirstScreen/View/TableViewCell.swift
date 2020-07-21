//
//  TableViewCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/11/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityLBL: UILabel!
    override var isSelected: Bool {
        didSet {
            if isSelected {
                accessoryType = .checkmark
                
            } else {
                accessoryType = .none
                
            }
        }}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
