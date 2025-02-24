//
//  BaseViewControllerProtocol.swift
//
//  Created by mohamed abdo on 5/31/18.
//

import Foundation
import UIKit

// MARK: - ...  Base Controller must be implement this protocol
protocol BaseViewControllerProtocol {
    func setup()
    func setupBase()
    func push(_ view: UIViewController, _ animated: Bool)
}
extension BaseViewControllerProtocol where Self: BaseController {
    func setup() {

    }
    func push(_ view: UIViewController, _ animated: Bool = true) {
        self.navigationController?.pushViewController(view, animated: animated)
    }
}
