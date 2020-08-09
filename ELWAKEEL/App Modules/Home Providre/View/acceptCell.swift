//
//  acceptCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework

protocol buttons {
    func cancel()
    func accept()
}
class acceptCell: UITableViewCell {

    
    var delegate: buttons?
    @IBOutlet weak var requestNum: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var des: UILabel!
    
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var accept: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cancel.layer.cornerRadius = 10
        accept.layer.cornerRadius = 10
        cancel.titleLabel?.text = Localization.cancel
        accept.titleLabel?.text = Localization.accept
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func accept(_ sender: Any) {
        delegate?.accept()
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.cancel()
    }
    
    
    
}
