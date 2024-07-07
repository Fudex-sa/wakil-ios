//
//  EmptyScreenContract.swift
//  geoshield
//
//  Created by Mabdu on 08/04/2021.
//  Copyright © 2021 com. All rights reserved.
//

import Foundation
import UIKit
protocol NetworkFailScreenContract: AnyObject {
    
}

extension NetworkFailScreenContract where Self: BaseController {
    func showNetworkFailScreen(for top: CGFloat = 0) {
        stopLoading()
        hideNetworkFailScreen()
        networkScreen = NetworkFailScreen()
        networkScreen.container.backgroundColor = self.view.backgroundColor
        self.view.addSubview(networkScreen)
        networkScreen.addTopConstraint(toView: view, constant: top)
        networkScreen.addLeadingConstraint(toView: view)
        networkScreen.addTrailingConstraint(toView: view)
        networkScreen.addBottomConstraint(toView: view, constant: 0)
    }
    func hideNetworkFailScreen() {
        if networkScreen != nil && networkScreen.superview != nil {
            networkScreen.removeFromSuperview()
        }
    }
}
