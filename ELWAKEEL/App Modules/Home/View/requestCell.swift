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
    
    @IBOutlet weak var new: UILabel!
    
    @IBOutlet weak var last: UILabel!
    
    var requests_action: ((Any) -> Void)?
    
    @objc func requests_pressed(sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        requestNum2.layer.masksToBounds = true
        requestNum2.layer.cornerRadius = requestNum2.frame.width/2
        showNumberLBL.layer.masksToBounds = true
        showNumberLBL.layer.cornerRadius = showNumberLBL.frame.width/2
        requestNum2.adjustsFontSizeToFitWidth = true
        requestStatus.adjustsFontSizeToFitWidth = true
        requesteAccept.adjustsFontSizeToFitWidth = true
        new.layer.cornerRadius = 10
        new.layer.masksToBounds = true
        last.layer.cornerRadius = 10
        last.layer.masksToBounds = true

       
    }
    
    
    @IBAction func go_to_accepts(_ sender: Any) {
        self.requests_action?(sender)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
