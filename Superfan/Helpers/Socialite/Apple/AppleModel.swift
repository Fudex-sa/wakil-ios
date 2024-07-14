//
//  GoogleModel.swift
//  Ryde
//
//  Created by Mohamed Abdu on 6/11/18.
//  Copyright © 2018 Ryde. All rights reserved.
//

import Foundation
import GoogleSignIn

class AppleModel: SocialModel {
    var id: String?
    var token: String?
    var fullName: String?
    var givenName: String?
    var middleName: String?
    var familyName: String?
    var email: String?
    init() {
        super.init(type: .apple)
    }
    
}
