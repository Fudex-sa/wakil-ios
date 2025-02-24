//
//  UICollection+SkeletonEX.swift
//  BookistaProvider
//
//  Created by Mabdu on 26/04/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func skeleton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.reloadData()
        }
    }
    func reloadAfter(_ time: DispatchTime, handler: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            self?.reloadData() {
                handler?()
            }
        }
    }
}
