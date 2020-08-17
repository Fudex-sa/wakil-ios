//
//  acceptCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework

class acceptCell: UITableViewCell {

    
    @IBOutlet weak var requestNum: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var accept: UIButton!
    var cancel_action: ((Any) -> Void)?
    
    @objc func cancel_pressed(sender: Any) {
    }
    
    var accept_button: ((Any) -> Void)?
    
    @objc func accept_pressed(sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cancel.layer.cornerRadius = 10
        accept.layer.cornerRadius = 10
        cancel.setTitle(Localization.cancel, for: .normal)
        accept.setTitle(Localization.accept, for: .normal)
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func accept(_ sender: Any) {
          self.accept_button?(sender)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.cancel_action?(sender)

    }
    
    
    
}
