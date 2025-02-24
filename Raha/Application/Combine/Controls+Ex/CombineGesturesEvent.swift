//
//  CombineTapEvent.swift
//  Wndo
//
//  Created by M.abdu on 07/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import Combine
import UIKit
// MARK: - Publisher
@available(iOS 13.0, *)
public extension Combine.Publishers {
    struct GesturePublisher: Combine.Publisher {
        public typealias Output = GestureType
        public typealias Failure = Never
        private let view: UIView
        private let gestureType: GestureType
        init(view: UIView, gestureType: GestureType) {
            self.view = view
            self.gestureType = gestureType
        }
        public func receive<S>(subscriber: S) where S : Subscriber,
        GesturePublisher.Failure == S.Failure, GesturePublisher.Output
        == S.Input {
            let subscription = GestureSubscription(
                subscriber: subscriber,
                view: view,
                gestureType: gestureType
            )
            subscriber.receive(subscription: subscription)
        }
    }
    
}


// MARK: - Subscription
@available(iOS 13.0, *)
extension Combine.Publishers.GesturePublisher {
    class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
        private var subscriber: S?
        private var gestureType: GestureType
        private var view: UIView
        init(subscriber: S, view: UIView, gestureType: GestureType) {
            self.subscriber = subscriber
            self.view = view
            self.gestureType = gestureType
            configureGesture(gestureType)
        }
        private func configureGesture(_ gestureType: GestureType) {
            let gesture = gestureType.get()
            gesture.addTarget(self, action: #selector(handler))
            view.addGestureRecognizer(gesture)
        }
        func request(_ demand: Subscribers.Demand) { }
        func cancel() {
            subscriber = nil
        }
        @objc
        private func handler() {
            _ = subscriber?.receive(gestureType)
        }
    }
    
    public enum GestureType {
        case tap(UITapGestureRecognizer = .init())
        case swipe(UISwipeGestureRecognizer = .init())
        case longPress(UILongPressGestureRecognizer = .init())
        case pan(UIPanGestureRecognizer = .init())
        case pinch(UIPinchGestureRecognizer = .init())
        case edge(UIScreenEdgePanGestureRecognizer = .init())
        func get() -> UIGestureRecognizer {
            switch self {
            case let .tap(tapGesture):
                return tapGesture
            case let .swipe(swipeGesture):
                return swipeGesture
            case let .longPress(longPressGesture):
                return longPressGesture
            case let .pan(panGesture):
                return panGesture
            case let .pinch(pinchGesture):
                return pinchGesture
            case let .edge(edgePanGesture):
                return edgePanGesture
           }
        }
    }
}

