//
//  chat_cell.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class chat_cell: UITableViewCell {
    enum direction {
        case incoming
        case outgoing
    }
    
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var message_text: UITextView!
    @IBOutlet weak var stack_view: UIStackView!
    @IBOutlet weak var profile: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        set_up_cell()
    }
    func set_up_cell(){
        container_view.layer.cornerRadius = 7
        
        
    }
    func stack_direction(type: direction)
       {
           if type == .incoming{
            stack_view.alignment = .leading
            container_view.backgroundColor = UIColor(red: 0.25, green: 0.27, blue: 0.60, alpha: 1.00)
            message_text.textColor = UIColor.white
            
           }
           else if type == .outgoing
           {
            stack_view.alignment = .trailing
            container_view.backgroundColor = UIColor.white
            message_text.textColor = UIColor.black

           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
