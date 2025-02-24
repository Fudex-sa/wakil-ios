//
//  UITableViewEx.swift
//  BookistaProvider
//
//  Created by Mabdu on 22/04/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func autoHeight(for view: UIView? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
                constraint.constant = self.contentSize.height
                if view != nil && constraint.constant > (view?.height ?? 0) - 350 {
                    constraint.constant = (view?.height ?? 0) - 350
                }
            }
        }
    }

    func reloadHeight(for time: DispatchTime = .now() + 0.1) {
        DispatchQueue.main.asyncAfter(deadline: time) {
            if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
                constraint.constant = self.contentSize.height
            }
        }
    }
    
    func setHeight(for height: CGFloat = 200) {
        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = height
        }
    }
}

