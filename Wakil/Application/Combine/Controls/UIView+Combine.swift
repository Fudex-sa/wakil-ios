//
//  UIView+Combine.swift
//  Wndo
//
//  Created by M.abdu on 07/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//
#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
extension UIView {
    var publisherGesture: AnyPublisher<Combine.Publishers.GesturePublisher.GestureType, Never> {
        gestureCombine(.tap()).eraseToAnyPublisher()
    }
    
    private func gestureCombine(_ gestureType: Combine.Publishers.GesturePublisher.GestureType = .tap()) ->
    Combine.Publishers.GesturePublisher {
        .init(view: self, gestureType: gestureType)
    }
}

#endif
