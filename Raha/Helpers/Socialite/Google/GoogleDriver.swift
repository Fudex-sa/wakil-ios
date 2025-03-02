////
////  GoogleProvider.swift
////  RedBricks
////
////  Created by Mohamed Abdu on 6/11/18.
////  Copyright © 2018 Atiaf. All rights reserved.
////

import Foundation
import GoogleSignIn

class GoogleDriver: SocialIndicator {
    typealias CallbackGoogle = (GoogleModel?, _ error: String?) -> Void
    private var closurePrivate: CallbackGoogle?
    var closure: CallbackGoogle? {
        set {
            closurePrivate = newValue
        } get {
            return closurePrivate
        }
    }
    func fetch(presenting at: UIViewController) {
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance.signIn(withPresenting: at) { user, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.closure?(nil, error.localizedDescription)
                    }
                } else {
                    let model = GoogleModel(user: user?.user)
                    DispatchQueue.main.async {
                        self.closure?(model, nil)
                    }
                }
            }
        }
    }
}
