//
//  CentersTableViewCell.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class CentersTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var servicesCollection: UICollectionView!
    @IBOutlet weak var desLbl: UILabel!
}
