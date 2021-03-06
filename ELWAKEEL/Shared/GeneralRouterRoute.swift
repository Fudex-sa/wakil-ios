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
    case addrequest(params: [String: Any]?)
    case requestDetails(id: Int, statu: String?)
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
    case provider_notifications
    case client_notifications
    case edit(id: Int)
    case offer(request_id: Int)
    case payment (params: [String: Any])
    case accecpt_provider(request_id: Int)
    case provider_log
    case request_details_provider(request_id: Int)
    case details(request_id: Int)
    case chat(params:[String:Any])
    case edit_profile
    case change_name
    case change_address
    case change_city
    case change_password
    case change_phone

    
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
            
        case .addrequest(let params):
            return addrequestConfiguration.setup(parameters: params ?? ["": ""])
        case .requestDetails(let id, let status):
            return requestDetailsConfiguration.setup(id: id, statu: status)
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
        case .provider_notifications:
            return Provider_NotificationConfiguration.setup()
        case .client_notifications:
            return Clint_NotificationConfiguration.setup()
        case .edit(let id):
            return editConfiguration.setup(id: id)
        case .offer(let request_id):
            return Accept_RequestConfiguration.setup(request_id: request_id)
        case .payment (let params):
            return paymentConfiguration.setup(parameters: params)
        case .accecpt_provider(let request_id):
            return accept_reuestConfiguration.setup(request_id: request_id)
        case .provider_log:
            return provider_logConfiguration.setup()
        case .request_details_provider(let request_id):
            return request_detailsConfiguration.setup(request_id: request_id)
        case .details(let request_id):
            return detailsConfiguration.setup(request_id: request_id)
        case .chat(let params):
            return ChatConfiguration.setup(parameters: params)
        
        case .edit_profile:
            return edit_profileConfiguration.setup()
        case .change_name:
            return change_nameConfiguration.setup()
        case .change_city:
            return change_cityConfiguration.setup()
        
        case .change_address:
            return change_addressConfiguration.setup()
        case .change_password:
            return change_passwordConfiguration.setup()
        case .change_phone:
            return change_phoneConfiguration.setup()
        }
}
}
