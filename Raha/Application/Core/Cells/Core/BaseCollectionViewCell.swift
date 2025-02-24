//
//  BaseTableViewCell.swift
//  Wndo
//
//  Created by M.abdu on 07/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CellProtocol, Combining {
    var imageContainerLoader: UIImageView? = .init()
    var loaderGIF: UIImage = .init()
    var subscriptions: Set<Subscriptions> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        removeSubscription()
    }
    
    func setup() {
        subscriptions.removeAll()
    }
}
