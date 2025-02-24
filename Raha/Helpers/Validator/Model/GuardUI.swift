//
//  GuardUI.swift
//  BaseIOS
//
//  Created by Mabdu on 07/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  GUard UI for super view text field
internal class GuardUI {
    var view: UIView?
    var imageView: UIView?
    var oldTextColor: UIColor = .black
    var oldPlaceHolderColor: UIColor = .placeholderText
    var holdColor: Bool = false {
        didSet {
            setOldColor()
        }
    }
    weak var textField: UITextField!
    
    init() {
        
    }
    func setOldColor() {
        self.oldTextColor = textField.textColor ?? .black
        // retrieve attributes
        let attributes = textField.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil)
        // iterate each attribute
        for attr in attributes ?? [:] {
            if attr.key == .foregroundColor {
                self.oldPlaceHolderColor = (attr.value as? UIColor) ?? .placeholderText
            }
        }
    }
}
