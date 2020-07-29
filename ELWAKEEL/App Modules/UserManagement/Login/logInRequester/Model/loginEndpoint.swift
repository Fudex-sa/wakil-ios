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

enum loginEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case login(phone: String, password: String, type: String)
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
            
        case .login(let phone, let password, let type):
//            let defaults = UserDefaults.standard
//            let device_token = defaults.string(forKey: "firebase_token")
            return ["phone": phone , "password": password , "type": type]
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
        switch self {
        case .login:
            return ["Accept": "application/json", "Accept-Language":"ar", "Content-Type":"application/json"]
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
