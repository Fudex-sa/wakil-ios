//
//  NetworkResponse.swift
//  BaseIOS
//
//  Created by M.abdu on 10/13/20.
//  Copyright © 2020 com.Abdu. All rights reserved.
//

import Foundation
// MARK: - ...  Network Response
enum NetworkResponse<T: Codable> {
    case success(T?)
    case failure(Error?)
}
