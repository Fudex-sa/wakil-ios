//
//  requestCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/20/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class requestCell: UITableViewCell {

    
    @IBOutlet weak var requestNumLBL: UILabel!
    
    
    @IBOutlet weak var showNumberLBL: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var requestDESLBL: UILabel!
    @IBOutlet weak var requestAddresBL: UILabel!
    @IBOutlet weak var requesteAccept: UILabel!
    @IBOutlet weak var requestNum2: UILabel!
    @IBOutlet weak var goTORequest: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        requestNum2.layer.masksToBounds = true
        requestNum2.layer.cornerRadius = requestNum2.frame.width/2
        showNumberLBL.layer.masksToBounds = true
        showNumberLBL.layer.cornerRadius = showNumberLBL.frame.width/2
        requestNum2.adjustsFontSizeToFitWidth = true
       showNumberLBL.adjustsFontSizeToFitWidth = true
        requestStatus.adjustsFontSizeToFitWidth = true
        requesteAccept.adjustsFontSizeToFitWidth = true

       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
