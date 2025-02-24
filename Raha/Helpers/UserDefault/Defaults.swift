//
//  Defaults.swift
//  BaseIOS
//
//  Created by Mabdu on 14/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation

// MARK: - ...  Defaults properties
internal class Defaults {
    struct Static {
        static var instance: Defaults?
    }
    
    @StoredDefaults("userDataDefaults")
    var user: UserRoot?
    
    @StoredDefaults("clubDataDefaults")
    var club: SelectclubDatum?
    
    @StoredDefaults("USER_LOGIN_REMEMBER")
    var LoginRemember: Bool?
    
    @StoredDefaults("USER_ONBOARDING")
    var onboarding: Bool?
    
    @StoredDefaults("expires_in")
    var expiresToken: Int?
    
    @StoredDefaults("LOGIN_TIMESTAMP")
    var loginTimeStamp: Int?
    
    @StoredDefaults("DEVICE_TOKEN")
    var DEVICE_TOKEN: String?
    
    @StoredDefaults("locale")
    var locale: String?
    
    @StoredDefaults("default.language.ia")
    var defaultLangauge: String?

    @StoredDefaults("notificationStatus")
    var notificationStatus: Bool?
    
    @StoredDefaults("APP_MODE")
    var APP_MODE: String?
    
    @StoredDefaults("USER_LOGIN_REMEMBER")
    var userRemember: Bool?
    
    @StoredDefaults("USER_PHONE_CODE")
    var userPhoneCode: String?
    
    @StoredDefaults("USER_PHONE_VALUE")
    var userPhone: String?
    
    @StoredDefaults("USER_LOGIN_EMAIL")
    var userEmail: String?
    
    @StoredDefaults("USER_LOGIN_PASSWORD")
    var userPassword: String?
    
    @StoredDefaults("GUEST_TOKEN")
    var GUEST: String?
    
    @StoredDefaults("USER.APP.MODE")
    var userAppMode: APP.Mode?
    
    @StoredDefaults("SIGNAL.R_URL")
    var SignalRUrl: String?
}
