//
//  ViewHelper.swift
//  SupportI
//
//  Created by mohamed abdo on 7/30/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

typealias HandlerView = (() -> Void)
internal var handlerActions: [UIView: HandlerView] = [:]
extension UIView {
    internal static func emptyHanlder() {
        handlerActions = [:]
    }
    internal func emptyHanlder() {
        handlerActions = [:]
    }
    internal func UIViewAction(selector: @escaping HandlerView) {
        self.isUserInteractionEnabled = true
        actionHandleBlock(action: selector)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.triggerActionHandleBlock))
        self.addGestureRecognizer(tap)
    }
    internal func actionHandleBlock(action:(() -> Void)? = nil) {
        if action != nil {
            handlerActions[self] = action
        } else {
            guard let action = handlerActions[self] else { return }
            action()
        }
    }
    @objc func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
}


extension UIView {
    func hexaCodeToColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
    }
}
