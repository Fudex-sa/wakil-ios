//
//  UICollection+SkeletonEX.swift
//  BookistaProvider
//
//  Created by Mabdu on 26/04/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

extension BaseController {
    private func animated(for view: UIView?) {
        view?.isSkeletonable = true
        view?.showAnimatedGradientSkeleton()
        view?.layoutSkeletonIfNeeded()
        view?.layoutSkeletonLayerIfNeeded()
    }
    private func stopAnimated(for view: UIView?) {
        view?.hideSkeleton()
    }
    func skeleton(for views: UIView?..., animate: Bool = true) {
        if animate == true {
            views.forEach({ (view) in
                self.animated(for: view)
            })
        } else {
            views.forEach({ (view) in
                self.stopAnimated(for: view)
            })
        }
    }
}
