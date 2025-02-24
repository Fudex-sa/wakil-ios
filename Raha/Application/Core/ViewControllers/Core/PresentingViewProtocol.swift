//
//  CorePresentingViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

// All ViewControllers must implement this protocol
protocol PresentingViewProtocol: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didError(error: String?)
}

// implementation of PresentingViewProtocol only in cases where the presenting view is a UIViewController
extension PresentingViewProtocol where Self: BaseController {
}
