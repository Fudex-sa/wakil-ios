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
    enum Environment {
        case live
        case test
        case stage
    }
    struct Config {
        static var environment: Environment = .test  // Change this to .test for testing

        static var baseURL: String {
            switch environment {
            case .live:
                return "http://sfanz.co/api/v4/"
            case .test:
                return "https://demo.raha.fudex-tech.net/api/v1/"
            case .stage:
                return "https://stage.raha.fudex-tech.net/api/v1/"
            }
        }
        static var firebaseTopic: String {
            switch environment {
            case .live:
                return "superfan_ios_live"
            case .test:
                return "superfan_ios_demo"
            case .stage:
                return "superfan_ios_stage"
            }
        }
    }
    static var _URL: String?
//    static var URL: String = "http://sfanz.co/api/v2/"
    static var URL: String = Config.baseURL
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
        case login = "client/login"
        case countries
        case validteregister = "checkRegisterValidation"
        case register = "client/register"
        case news = "client/news"
        case confirmotp = "client/confirm-otp-register"
        case sendotp = "client/send-otp"
        case resetpass = "client/forgotPassword"
        case checkotp = "client/check-otp"
        case updateemail = "client/updateEmail"
        case updatepassword = "client/updatePassword"
        case about = "client/pages/about-us"
        case terms = "client/pages/terms-and-conditions"
        case privacy = "client/pages/privacy-policy"
        case updatephone = "client/updateMobile"
        case profile = "client/profile"
        case updateprofile = "client/updateProfile"
        case deleteaccount = "client/deleteAccount"
        case matches
        case todaymatxh = "todayMatches"
        case perviousmatch = "previousMatches"
        case nextmatches = "nextMatches"
        case home = "client/branches"
        case players = "client/players"
        case leagues = "leagues"
        case clubs = "client/clubs"
        case faqs = "client/faqs"
        case setting
        case favclub = "client/fanFavouriteClubUpdate"
        case contactus = "client/contact-us"
        case logout = "client/logout"
        case clubdetails = "client/clubs/"
        case paymentmethod = "checkoutDetails"
        case tryouts = "client/tryouts"
        case maketryout = "client/makeTryout"
        case mytryouts = "client/myTryouts"
        case tryoutsstatus = "client/myTryoutsFilters"
        case notificationcount = "client/notificationsCount"
        case socialLogin = "client/checkSocialUser"
        case years = "client/years"
        case playerserach = "client/players/search"
        case posts = "client/posts"
        case myposts = "client/myPosts"
        case deletemedia = "client/postMedia"
        case comments = "client/comments"
        case packages = "client/packages"
        case mySubscriptions = "client/mySubscriptions"
        case Subscriptions = "client/subscriptions"
        case backstages = "client/backstages"
        case standing
        case paymentMethods
        case refreshToken = "/api/app/register/refresh-token"
        case checkSubscriptionSellers = "client/checkSubscriptionSellers"
        case settingsubscribe = "setting/packages_available_v4"
        case addresses = "client/userAddresses"
        case states = "client/states"
        case cities = "client/cities"
        case servicetype = "client/serviceTypes"
        case sliders = "client/sliders"
        case slots = "client/slots"
        case createorder = "client/order"
        case myorders = "client/my-orders"
        case orderdetails = "client/orders/"
        case cancelpolicy = "client/pages/cancellation-policy"
        case compalins = "client/my-complaint-suggesstion"
        case sendcompalin = "client/complaintOrSuggest"
        case notifications = "client/notifications"
        case deletenotification = "client/notifications/delete"
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
