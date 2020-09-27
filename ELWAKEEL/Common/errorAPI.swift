//
//  errorAPI.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright © 2020 Fudex. All rights reserved.
//


import Foundation

struct ErrorModel: Codable  {
    
    let code: Int?
    let message: String?
    let data: [String]?
    
    init(code: Int?, message: String?, data: [String]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct ErrorResponse : Codable {
    
    let error: Bool
    let errors: [ErrorModel]
    
}
