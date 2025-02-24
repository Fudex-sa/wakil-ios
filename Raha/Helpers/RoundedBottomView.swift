//
//  RoundedView.swift
//  Tifo
//
//  Created by ADAM on 06/06/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedBottomView: UIView {

    @IBInspectable var cornerradius: CGFloat = 30 {
        didSet {
            updateMask()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft,.bottomRight],
            cornerRadii: CGSize(width: cornerradius, height: cornerradius)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }
}
