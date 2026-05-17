//
//  AppleDriver.swift
//  Ryde
//
//  Created by Mohamed Abdu on 14/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleDriver: NSObject, SocialIndicator {
    typealias CallbackApple = (AppleModel?, _ error: String?) -> Void
    private var closurePrivate: CallbackApple?
    var closure: CallbackApple? {
        set {
            closurePrivate = newValue
        } get {
            return closurePrivate
        }
    }
    func decodeJWT(jwt: Data?) -> String? {
        // ...
        if let identityTokenData = jwt,
           let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
           print("Identity Token \(identityTokenString)")
           do {
              let jwt = try JWTdecode(jwt: identityTokenString)
              let decodedBody = jwt.body as Dictionary<String, Any>
              print(decodedBody)
              print("Decoded email: "+(decodedBody["email"] as? String ?? "n/a")   )
               return decodedBody["email"] as? String
           } catch {
              print("decoding failed")
           }
        }
        return nil
    }
}

extension AppleDriver: ASAuthorizationControllerDelegate {
    @objc func fetch() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension AppleDriver {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let token = appleIDCredential.user
            let nameComponent = appleIDCredential.fullName
            let email = decodeJWT(jwt: appleIDCredential.identityToken)
            if email?.isEmpty == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.closure?(nil, "Please make sure select provide your email from apple account".localized)
                }
                return
            }
            let model = AppleModel()
            model.id = token
            model.token = token
            model.fullName = nameComponent?.givenName
            model.givenName = nameComponent?.givenName
            model.middleName = nameComponent?.givenName
            model.familyName = nameComponent?.familyName
            model.email = email
            closure?(model, nil)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
      
    }
}
