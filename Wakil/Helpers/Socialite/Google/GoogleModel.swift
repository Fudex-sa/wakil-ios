//
//  GoogleModel.swift
//  RedBricks
//
//  Created by Mohamed Abdu on 6/11/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleModel: SocialModel {
    var id: String?
    var token: String?
    var fullName: String?
    var givenName: String?
    var familyName: String?
    var email: String?
    init(user: GIDGoogleUser?) {
        super.init(type: .google)
        guard let user = user else {
            return
        }
        self.id = user.userID
        self.token = user.accessToken.tokenString
        self.fullName = user.profile?.name
        self.givenName = user.profile?.givenName
        self.familyName = user.profile?.familyName
        self.email = user.profile?.email
    }
    
}
