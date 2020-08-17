
//
//  accept.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework
import Cosmos
class accept: UITableViewCell {
    

    @IBOutlet weak var provider_image: UIImageView!
    @IBOutlet weak var provider_name: UILabel!
    @IBOutlet weak var provider_Des: UILabel!
    @IBOutlet weak var price_Des: UILabel!
    @IBOutlet weak var acceptBTN: UIButton!
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var rating: CosmosView!
    
//    @IBOutlet weak var rating: StarRatingView!
    var cancel_action: ((Any) -> Void)?
    
    @objc func cancel_pressed(sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        provider_image.layer.cornerRadius = provider_image.frame.width / 2
        provider_image.layer.masksToBounds = true
        provider_Des.text = Localization.provider_name
        price_Des.text = Localization.app_price
        acceptBTN.setTitle( Localization.accept, for: .normal)
        
        
        
    }

    
    @IBAction func accept(_ sender: Any) {
        self.cancel_action?(sender)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
