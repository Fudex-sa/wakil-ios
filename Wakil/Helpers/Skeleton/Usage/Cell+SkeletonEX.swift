//
//  UICollection+SkeletonEX.swift
//  BookistaProvider
//
//  Created by Mabdu on 26/04/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

extension CellProtocol {
    public func skeleton(view: UIView? = nil) {
        var skeleton: UIView!
        if view == nil {
            skeleton = self as? UIView
        } else {
            skeleton = view
        }
        skeleton.subviews.forEach({ (view) in
            if view is UIButton {
                return
            }
            if view.subviews.count > 0 {
                self.skeleton(view: view)
                return
            }
            if view is UILabel || view is UIImageView {
                self.animated(for: view)
            }
        })
    }
    func animated(for view: UIView?) {
        if model == nil {
            view?.isSkeletonable = true
            view?.layoutSkeletonIfNeeded()
            view?.layoutSkeletonLayerIfNeeded()
            view?.showAnimatedGradientSkeleton()
            view?.layoutSkeletonIfNeeded()
            view?.layoutSkeletonLayerIfNeeded()
        } else {
            view?.hideSkeleton()
        }
    }
    func stopAnimated(for view: UIView?) {
        view?.hideSkeleton()
    }
    func skeleton(for views: UIView?...) {
        views.forEach({ (view) in
            self.animated(for: view)
        })
    }
}

