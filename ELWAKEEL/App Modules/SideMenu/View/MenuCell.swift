//
//  MenuCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var item: UILabel!
//    override var isSelected: Bool {
//    didSet {
//        if isSelected {
//            accessoryType = .checkmark
//            
//        } else {
//            accessoryType = .none
//            
//        }
//    }}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
