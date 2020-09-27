//
//  loginEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum loginEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case login(phone: String, password: String)
}

extension loginEndpoint: IEndpoint {
    var image: UIImage? {
        return nil
    }
    
    var method: HTTPMethod {
        /*
        Do like this:

        switch self {
        case .sample:
            return .get
        }
        */
        switch self{
        case .login:
        
        return .post
    }
    }
    var path: String {
        /*
        Do like this:

        switch self {
        case .sample:
            return "https://httpbin.org/get"
        }
        */
        
        switch self {
        case .login:
        return "http://wakil.dev.fudexsb.com/api/login"
            
        }
    }
    
    var parameter: Parameters? {
        /*
        Do like this:

        switch self {
        case .sample(let model):
            return model.parameter()
        }
        */
        
        switch self {
            
        case .login(let phone, let password):
            let defaults = UserDefaults.standard
            let type = defaults.string(forKey: "type")
            let mac = defaults.string(forKey: "mac")
            let firebabe_token = defaults.string(forKey: "firebase_token")

            print("mace",(mac))
            print("fire_base",(firebabe_token))
            return ["phone": phone , "password": password , "type": type!, "token": firebabe_token! , "mac": mac!]
        }
       
    }
    
    var header: HTTPHeaders? {
        /*
        Do like this:

        switch self {
        case .sample:
            return ["key": Any]
        }
        */
        let language = MOLHLanguage.currentAppleLanguage()

        switch self {
        case .login:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Content-Type":"application/json"]
        }
    }
    
    var encoding: ParameterEncoding {        
        /*
        Do like this:
        
        return URLEncoding.queryString for URL Query
        
        switch self {
        case .sample:
            return JSONEncoding.default
        }
        */
        switch self {
        case .login:
        return JSONEncoding.default
        }}
}
