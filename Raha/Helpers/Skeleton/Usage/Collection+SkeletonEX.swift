//
//  UICollection+SkeletonEX.swift
//  BookistaProvider
//
//  Created by Mabdu on 26/04/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func skeleton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.reloadData()
        }
    }
}
