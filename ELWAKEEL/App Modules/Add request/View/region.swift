//
//  region.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

class region: UIView {

    @IBOutlet weak var lab: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit()
    {
        let viewFromXib = Bundle.main.loadNibNamed("region", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}
