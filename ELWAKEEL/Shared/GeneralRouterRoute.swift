//
//  GeneralRouterRoute.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam/

import Foundation
import UIKit

enum GeneralRouterRoute: IRouter {
    /*
     If you want passing with parameters
     you just add like this:
     
     case sample
     case sample(parameter: [String: Any])
     
     you can use: String, Int, [String: Any], etc..
    */
    case login(type: String)
    case supplierFirst(type: String)
    case suppilerSecond(id: Int)
    case HomeLogIn
    case LoginRequester(type: String)
    case verification(params: [String:Any])
    case registrationType
    case creatingPassword(type: String, id: Int)
    case forgetPassword
    case newPassword(phone: String)
    case Home
    case sideMenu
    case addrequest
    case requestDetails
    case editRequest(id: Int)
    case aboutUs
    case HomeProvider
    case sideMenuProvider
    case requestsRecord
    case applicationSetting
    case contactUs
    case commonQuestios
    case terms
    case wallet
    
    
    
}

extension GeneralRouterRoute {
    var module: UIViewController? {
        switch self{
        case .login(let type):
            return LOGINRequesterConfiguration.setup(userTypeL: type)
        case.supplierFirst(let type):
            return SupplierFirstScreenConfiguration.setup(type: type)
        case .suppilerSecond(let id):
            return secondScreenConfiguration.setup(id: id)
        case .HomeLogIn:
            return LOGINConfiguration.setup()
        case .LoginRequester(let type):
            return CreatingRequesterConfiguration.setup(type: type)
        case .verification(let params):
            return VerificationConfiguration.setup(parameters: params)
        case.registrationType:
            return registraionTypeConfiguration.setup()
        case .creatingPassword(let type, let id):
            return creatingPasswordConfiguration.setup(type: type, id: id)
        case.forgetPassword:
            return ForgetpasswordConfiguration.setup()
        case .newPassword(let phone):
            return NewPasswordConfiguration.setup(phone: phone)

        case .Home:
            return HomeConfiguration.setup()
        case .sideMenu:
            return sideMenuConfiguration.setup()
            
        case .addrequest:
            return addrequestConfiguration.setup()
        case .requestDetails:
            return requestDetailsConfiguration.setup()
        case .editRequest(let id):
            return editRequestConfiguration.setup(id: id)
        
        case .aboutUs:
            return aboutUsConfiguration.setup()
        case .HomeProvider:
            return HomeProviderConfiguration.setup()
        case .sideMenuProvider:
            return sideMenuProviderConfiguration.setup()
        case .requestsRecord:
            return requestrecordConfiguration.setup()
        case .applicationSetting:
            return applicationSettingConfiguration.setup()
        case .contactUs:
            return contactUsConfiguration.setup()
        case .commonQuestios:
            return commonQuestionsConfiguration.setup()
        case .terms:
            return termsConfiguration.setup()
        case .wallet:
            return walletConfiguration.setup()
        }
        
    }
}
