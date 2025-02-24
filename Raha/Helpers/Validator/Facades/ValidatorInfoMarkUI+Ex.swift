//
//  ValidatorInfoMarkUI+Ex.swift
//  BaseIOS
//
//  Created by Mabdu on 07/06/2021.
//  Copyright © 2021 com.m.abdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Extension of validator info mark
extension ValidatorInfoMarkUI {
    func insertInfoMark(in model: GuardModel?) {
        guard let model = model else { return }
        guard let view = model.textField.superview else { return }
        
//        let containView = UIView()
//        view.addSubview(containView)
//        containView.addCenterYConstraint(toView: view)
//        containView.addTrailingConstraint(toView: view, constant: -15)
//        containView.addHeightConstraint(toView: nil, constant: 25)
//        containView.addWidthConstraint(toView: nil, constant: 25)
        
        let infoMark = UIImageView()
        infoMark.image = #imageLiteral(resourceName: "exclamation-mark-in-a-circle")
        view.addSubview(infoMark)
        infoMark.addCenterYConstraint(toView: view)
        infoMark.addTrailingConstraint(toView: view, constant: -15)
        infoMark.addHeightConstraint(toView: nil, constant: 25)
        infoMark.addWidthConstraint(toView: nil, constant: 25)
        model.imageView = infoMark
    }
    func removeInfoMark(in model: GuardModel?) {
        guard let model = model else { return }
        guard let view = model.textField.superview else { return }
        for view in view.subviews {
            if let image = view as? UIImageView {
                if image.image == #imageLiteral(resourceName: "exclamation-mark-in-a-circle") {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
