
//import UIKit
//import FacebookLogin
//import FacebookCore
//
//typealias CallbackFacebook = (FacebookModel) -> Void
//
//class FacebookDriver: SocialError, SocialIndicator {
//    weak var viewController: UIViewController?
//    
//    init(delegate: UIViewController) {
//        self.viewController = delegate
//    }
//
//    static func logout() {
//        Profile.current = nil
//        AccessToken.current = nil
//        LoginManager().logOut()
//    }
//
//    func checkFBlogin() -> Bool {
//        return AccessToken.current != nil
//    }
//
//    func callback(completionHandler: @escaping CallbackFacebook) {
//        if checkFBlogin() {
//            fetchUserProfile(completionHandler: completionHandler)
//        } else {
//            let loginManager = LoginManager()
//            loginManager.logIn(permissions: ["public_profile", "email"], viewController: viewController) { result in
//                switch result {
//                case .success(_, _, _):
//                    self.startLoading()
//                    self.fetchUserProfile(completionHandler: completionHandler)
//                case .failed(let error):
//                    print("Facebook Login Failed: \(error.localizedDescription)")
//                    self.alertError()
//                case .cancelled:
//                    print("Facebook Login Cancelled")
//                    self.alertError()
//                }
//            }
//        }
//    }
//
//    func fetchUserProfile(completionHandler: @escaping CallbackFacebook) {
//        guard let accessToken = AccessToken.current else {
//            print("No access token available")
//            self.alertError()
//            return
//        }
//
//        let request = GraphRequest(graphPath: "me", parameters: [
//            "fields": "id,name,first_name,relationship_status,email,picture.width(480).height(480)"
//        ], tokenString: accessToken.tokenString, version: nil, httpMethod: .get)
//
//        request.start { _, result, error in
//            self.stopLoading()
//            if let error = error {
//                print("GraphRequest Error: \(error.localizedDescription)")
//                self.alertError()
//                return
//            }
//
//            if let fbDetails = result as? [String: Any] {
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: fbDetails, options: .prettyPrinted)
//                    let facebook = FacebookModel.convertToModel(response: jsonData)
//                    facebook.parseImage(dic: fbDetails)
//                    completionHandler(facebook)
//                } catch {
//                    print("JSON Parsing Error")
//                    self.alertError()
//                }
//            } else {
//                print("Unexpected Graph API Response")
//                self.alertError()
//            }
//        }
//    }
//}
