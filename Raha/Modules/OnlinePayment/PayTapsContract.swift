//
//  NoonContract.swift
//  Mutsawiq
//
//  Created by Mabdu on 19/08/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation

protocol PayTapsDelegate: NSObjectProtocol {
    func payTaps(_ payTaps: PayTaps?, didPay orderID: Int)
    func payTaps(_ payTaps: PayTaps?, fail pay: Bool)
    func payTaps(_ payTaps: PayTaps?, cancel pay: Bool)
}

protocol PayTapsDataSource: NSObjectProtocol {
    func payTaps(_ payTaps: PayTaps?, successURL: Bool?) -> String?
    func payTaps(_ payTaps: PayTaps?, failURL: Bool?) -> String?
    func payTaps(_ payTaps: PayTaps?, URL: Bool?) -> String?
}
