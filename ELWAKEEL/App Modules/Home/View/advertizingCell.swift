//
//  advertizingCell.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/17/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework

class advertizingCell: UICollectionViewCell {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var seaAll: UIButton!
    
    
    var get_provider_id: ((Any) -> Void)?
    
    @objc func cancel_pressed(sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seaAll.setTitle(Localization.service_request, for: .normal)
       
       }
    
    
    @IBAction func sea_all(_ sender: Any) {
        self.get_provider_id?(sender)
    }
    

}
