//
//  CoordinatorProtocol.swift
//  BaseIOS
//
//  Created by M.abdu on 10/18/20.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
// MARK: - ...  Coordinator Protocol
// All Coordinators must implement this protocol
protocol CoordinatorProtocol {
    // Generic Type for any view
    associatedtype PresentingView
    var view: PresentingView? { get set }
}
