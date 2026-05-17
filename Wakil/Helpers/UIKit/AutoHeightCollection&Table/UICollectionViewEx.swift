//
//  UICollectionViewEx.swift
//  BookistaProvider
//
//  Created by Mabdu on 22/04/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
//    func autoHeight() {
//        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
//            constraint.constant = self.collectionViewLayout.collectionViewContentSize.height
//        }
//    }
    func autoHeight(for view: UIView? = nil) {
        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = self.collectionViewLayout.collectionViewContentSize.height
            if view != nil && constraint.constant < (view?.height ?? 0) - 350 {
                constraint.constant = (view?.height ?? 0) - 350
            }
        }
    }
}
