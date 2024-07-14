//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Network layer configration
struct NetworkConfigration {
    static var _URL: String?
//    static var URL: String = "https://tifo.fudex-tech.net/backend/public/api/"
    static var URL: String = "https://superfan.fudex-tech.net/api/v1/"
    static let VERSION = "v1"
    static var useAuth: Bool = false
    static var environment: NetworkConfigration.AppEnvironment? {
        let env = Bundle.main.infoDictionary?["ENV"] as? String ?? ""
        switch env {
            case "Development":
                return .Development
            case "Testing":
                return .Testing
            case "Beta":
                return .Beta
            case "Production":
                return .Production
            default:
                return .Development
        }
    }
   
    // MARK: - ...  The Endpoints
    public enum EndPoint: String {
        case forceUpdate = "/api/app/register/force-update"
        case login = "fan/login"
        case countries
        case states = "cities"
        case validteregister = "checkRegisterValidation"
        case register = "fan/register"
        case confirmotp = "fan/confirm-otp"
        case sendotp = "fan/send-otp"
        case resetpass = "fan/forgotPassword"
        case checkotp = "fan/check-otp"
        case updateemail = "fan/updateEmail"
        case updatepassword = "fan/updatePassword"
        case sendotpupdatephone = "fan/send-otp-mobile"
        case updatephone = "fan/update-otp-mobile"
        case profile = "fan/profile"
        case updateprofile = "fan/profile/update"
        case home = "fan/home"
        case players = "fan/players"
        case leagues = "fan/leagues"
        case clubs = "fan/clubs"
        case setting
        case contactus = "fan/sendContact"
        case logout = "fan/logout"
        case clubdetails = "fan/clubs/"
        case paymentmethod = "checkoutDetails"
        case tryouts = "fan/tryouts"
        case maketryout = "fan/makeTryout"
        case mytryouts = "fan/myTryouts"
        case tryoutsstatus = "fan/myTryoutsFilters"
        case notificationcount = "fan/notificationsCount"
        case notifications = "fan/notifications"
        case socialLogin = "fan/checkSocialUser"
        case years = "fan/years"
        case playerserach = "fan/players/search"
        case refreshToken = "/api/app/register/refresh-token"
    }
}

extension NetworkConfigration.EndPoint {
    static func endPoint(point: NetworkConfigration.EndPoint, paramters: [Any]) -> String {
        let method = NetworkManager.instance.slugs(point, paramters)
        return method
    }
}


extension NetworkConfigration {
    
    enum AppEnvironment: String {
        case Development
        case Testing
        case Beta
        case Production
    }
    
}
