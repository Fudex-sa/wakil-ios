//
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.

import Foundation
import UIKit
// MARK: - ...  UserAuth Controller
class UserRoot: Codable {

    var responseData: Token?
    var data: UserData?
    var expires_in: Int?
    var access_token: String?
    //var token: String?
    var isSuccess: Bool?
    var errorMessage: String?
    var statusCode: Int?
    var refresh_token: String?
    var message: String?
    var loginTimeStamp: Int?
}
// MARK: - ...  User Codable from API
extension UserRoot {
    class UserData: Codable {
        var user: User?
        var token: String?
    }
    class User: Codable {
        let id: Int?
        var email: String?
        var dialCode: String?
        var youtubeLink: String?
        var name: String?
        var photo: String?
        var avatar: String?
        var description: String?
        var mobile: String?
        var images: [String]?
        var whatsmobile: String?
        var timer: Int?
        var birthdate: String?
        var countryId: Int?
        var positionId: Int?
        var age: Int?
        var lat: String?
        var lng: String?
        var location: String?
        var birthyear: Int?
        var clubName: String?
        var prferedfoot: Int?
        var isverified: Int?
        var isSocial: Int?
        var city: DatumSelectCountryModel?
        var country: DatumSelectCountryModel?
        var companyOffers: [CompanyOffer]?
        enum CodingKeys: String, CodingKey {
            case id
            case email
            case age
            case avatar
            case lat
            case timer
            case lng
            case location
            case youtubeLink = "youtube_link"
            case isSocial = "is_social"
            case clubName = "club_name"
            case birthyear = "birth_year"
            case city
            case country
            case name
            case photo
            case whatsmobile = "whats_mobile"
            case birthdate = "birth_date"
            case countryId = "country_id"
            case prferedfoot = "prfered_foot"
            case positionId = "position_id"
            case isverified = "is_verified"
            case description
            case mobile
            case images
            case companyOffers = "company_offers"
            case dialCode = "dial_code"
            //case type
        }
        class CompanyOffer: Codable {
            var id: Int?
            var title: String?
            var icon: String?
        }
    }
    
    class Token: Codable {
        var access_Token: String?
        var refresh_Token: String?
        var expires_In: Int?
        var userId: String?
        var userName: String?
        var isVerified: Bool?
        var name: String?
        var isEgyptPhoneCode: Bool?
        var egPhone: String?
        var bio: String?
        var cover: String?
        var isMarketer: Bool?
        var isMarketerActive: Bool?
        var isDataCompleted: Bool?
        var marketerStep: Int?
        var profile: String?
        var picWithId: String?
        var dateOfBirth: String?
        var gender: Int?
        var text: String?
        var twitter: String?
        var facebook: String?
        var website: String?
        var email: String?
        var isDateCompleted: Bool?
        var password: String?
        var phone: String?
        var phoneNumber: String?
        var phoneCode: String?
        var isNotificationOn: Bool?
        var status: Int?
        var language: Int?
        var isDarkMode: Bool?
        var paymentType: Int?
        var isActiveSeller: Bool?
        var hasProduct, hasPrinter, hasName, hasPhone: Bool?
        var shopStatus: Bool?
        var isValid: Bool?
        var number: String?
        var supportEmail: String?
        var numbers: [String]?
        var productId: String?
        var taxes: Double?
        var WndoCommission: Double?
        var screen: Int?
        var api_key: String?
        var api_timestamp: String?
        var api_nonce: String?
        var api_signature: String?
        var id: Int?
        var products: Int?
        var videos: Int?
        var offers: Int?
        var isFirstLogin: Bool?
        var isExternalProvider: Bool?
        var followers: Int?
        var followings: Int?
        var likes: Int?
        var commentLikes: Int?
        var walletBalance:Double?
        var rate, notificationsCount: Int?
        var commercialRegistration: String?
        var taxCard: String?
        var bankAccountDetails: String?
        var sellerStatus: Int?
        var sendTo: String?
        var buyerGuideToSell: String?
        var sellerGuideToSell: String?
        var marketerGuideLink: String?
        var marketerPrivacyAndTermsLink: String?

        
    }
    

}
// MARK: - ...  Functions
extension UserRoot {
    // MARK: - ...  Function for Save user data
    public func save() {
        UD.user = self
    }
    // MARK: - ...  Function for fetch user data
    public static func fetch() -> UserRoot? {
        let user = UD.user
        return user
    }
    // MARK: - ...  Function for fetch token
    public static func token() -> String? {
        let user = UD.user
        return user?.data?.token
    }
    // MARK: - ...  Function for logout user
    public static func logout() {
        UD.user = UserRoot()
    }
    // MARK: - ...  Function for logout user
    public func logout() {
        UD.user = UserRoot()
    }
    // MARK: - ...  Function for fetch user data
    public static func user() -> User? {
        let user = UD.user
        return user?.data?.user
    }
    
//    public static func savesaller( remember: Bool = false) {
//        UserDefaults.standard.set(remember, forKey: isSeller)
//    }
//    public static func saller() -> Bool? {
//        let data = UserDefaults.standard.bool(forKey: isSeller)
//        return data
//    }
    
}


extension UserRoot {
    class Guest: Codable {
        var responseData: GuestToken?
        class GuestToken: Codable {
            var token: String?
        }
    }
}
