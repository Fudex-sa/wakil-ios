//
//  SelfSizingCollectionView.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//
import UIKit

class SelfSizingCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
